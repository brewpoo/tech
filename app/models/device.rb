class Device < ActiveRecord::Base

  acts_as_reportable

  before_save :update_device_type
  before_destroy :check_for_virtual

  belongs_to :device_class
  belongs_to :equipment
  belongs_to :contact

  belongs_to :device
  has_many :devices

#  belongs_to :domain
  belongs_to :primary_interface, :class_name => "Ipv4Interface",
    :foreign_key => "primary_interface_id"

  has_many :interfaces, :dependent => :destroy
  has_many :ipv4_interfaces, :through => :interfaces
  has_many :notes, :as => :notable, :dependent => :destroy
  has_many :maintenance_logs, :as => :loggable, :dependent => :destroy
  has_many :links, :as => :linkable, :dependent => :destroy
  has_many :domain_names, :as => :nameable, :dependent => :destroy

  validates_presence_of :hostname
#  validates_uniqueness_of :hostname, :scope => 'domain_id'

  validates_associated :device_class
  
  attr_accessor :remove
  attr_accessor :subnet
  attr_accessor :should_destroy

  def location
    self.equipment.location.full_name if self.equipment and self.equipment.location
  end

  def to_label
    return hostname if device_class.nil?
    "#{hostname} - #{device_class.name}"
  end

  def fqdn
    return nil if self.domain_names.empty?
    self.domain_names.first.fqdn
  end

  def main_ip_address
    if primary_interface
      address = primary_interface
    else
      address = ipv4_interfaces[0]
    end
    return address
  end

  def first_ip_address
    main_ip_address.ip_address unless main_ip_address.nil?
  end

  def forward_entry
    return nil if domain_names.empty?
    address = main_ip_address.ip_address
    return false unless Ipv4Interface.valid_address? address
    return "#{domain_names.first.name}  IN  A #{address}\n"
  end

  def reverse_entry
    address = main_ip_address
    return nil if domain_names.empty?
    return "#{address.octet(4)}.#{address.octet(3)}\tPTR\t#{domain_names.first.fqdn}.\n"
  end

  def Device.all_devices
    Device.find(:all,:order=>'hostname ASC').map{|d|["#{d.hostname}--#{d.device_class.name}",d.id]}
  end
    

  def self.select_map 
    all_devices = CACHE.get("all_devices")
    if all_devices == nil
      Device.run_precache
      all_devices = CACHE.get("all_devices")
    end
    return all_devices
  rescue
    return Device.all_devices
  end

  def address_select_map
    return Array.new if ipv4_interfaces_count == 0
    ipv4_interfaces.map{|i|[i.ip_address, i.id]}
  end

  private

  def check_for_virtual
    return false if is_virtual
  end

  def Device.all_select
    all_devices = CACHE.get("all_devices")
    if all_devices == nil
      Device.run_precache
      all_devices = CACHE.get("all_devices")
    end
    return all_devices
  rescue
    return Device.all_devices
  end

  def Device.server_devices
    server=DeviceClass.find_by_name("Server")
    Device.find(:all).select{|d| d.device_class==server}.sort_by{|d|d.hostname}.map{|d| ["#{d.hostname}", d.id]}
  end

  def Device.server_select
    server_devices = CACHE.get("server_devices")
    if server_devices == nil
      Device.run_precache
      server_devices = CACHE.get("server_devices")
    end
    return server_devices
  rescue
    return Device.server_devices
  end

  def Device.host_devices
    Device.find(:all).select{|d| !d.devices.empty?}.sort_by{|d|d.hostname}.map{|d| ["#{d.hostname}", d.id]}
  end

  def Device.host_select
    host_devices = CACHE.get("host_devices")
    if host_devices == nil
      Device.run_precache
      host_devices = CACHE.get("host_devices")
    end
    return host_devices
  rescue
    return Device.host_devices
  end


  def self.run_precache
    CACHE.set("server_devices",Device.server_devices)
    CACHE.set("all_devices",Device.all_devices)
    CACHE.set("host_devices",Device.host_devices)
  end

  def self.fix_domain_names
    Device.find(:all).each do |d|
      if !d.domain.nil?
        # Device currently has a domain
        # Make a new domain entry from it and remove the reference from Device
        d.create_in_domain_names(:domain=>d.domain,:hostname=>d.hostname,:publish_reverse=>true)
        d.domain = nil
        d.save
      else
        # Check for a domain in the hostname
        (hostname,domainname) = d.hostname.split(/\./,2)
        domain=Domain.find(:all).select{|r| r.fqdn == domainname}.first
        next if domain.nil?
        d.update_attributes(:hostname=>hostname)
        d.create_in_domain_names(:domain=>domain,:hostname=>hostname,:publish_reverse=>true) 
      end
    end
  end

  def self.missing_domain
    count=0
    Device.find(:all).each do |d|
      next unless d.device_class==DeviceClass.find_by_name("Server")
      if d.domain_names.empty?
        count=count+1
        if d.hostname.match('_')
           puts "Missing DNS: #{d.hostname}\n"
        end
      end
    end
    puts "Total missing #{count}"
    return nil
  end

  def self.set_device_type
    Device.find(:all,:conditions=>['device_class_id=?',DeviceClass.find_by_name("Server")]).each do |device|
      device.update_attribute(:type,"Server")
    end
    Device.find(:all,:conditions=>['device_class_id=?',DeviceClass.find_by_name("Printer")]).each do |device|
      device.update_attribute(:type,"Printer")
    end
  end

  def update_device_type
    if self.device_class==DeviceClass.find_by_name("Server")
      self.type = "Server"
    elsif self.device_class==DeviceClass.find_by_name("Printer")
      self.type = "Printer"
    else
      self.type = ""
    end
  end

end
