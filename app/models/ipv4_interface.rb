class Ipv4Interface < ActiveRecord::Base

  acts_as_reportable

  before_validation :set_subnet
  before_save :pack_address
  after_destroy :check_for_orphan

  belongs_to :ipv4_subnet
  belongs_to :interface, :include => :device
  delegate :device, :device=, :to => :interface
  has_many :ipv4_virtual_hosts, :dependent => :destroy
  has_many :ipv4_virtual_host_interfaces, :dependent => :destroy

#  has_many :domain_names, :as => :nameable, :dependent => :destroy

  validates_presence_of :ip_address
  validates_format_of :ip_address, :with => /\A(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)(?:\.(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)){3}\z/

  validates_uniqueness_of :ip_address, :scope => "ipv4_subnet_id"

  validates_presence_of :ipv4_subnet_id
  validates_associated :ipv4_subnet

  #validates_presence_of :interface, :unless => :virtual_interface
  attr_accessor :delete
  
  def created_by
    return 'not available in development' unless ENV['RAILS_ENV']=='production'
    return nil unless audits
    a=audits.select{|a|a.action=="create"}.first
    return unless a and a.user and a.user.contact
    a.user.contact.full_name
  end

  def owning_device
    return interface.device.to_label if interface and interface.device
  end

  def virtual_interface
    return true if is_virtual?
    return false
  end

  def to_label
    "#{ip_address}" if !ip_address.nil?
  end

  def octet(i)
    return false unless i > 0 and i < 5
    ip_address.split(".")[i-1]
  end

  def validate
    errors.add_to_base('Invalid IP Address for subnet') unless ipv4_subnet.nil? or ipv4_subnet.includes? ip_address
  end

  def self.valid_address?(ip)
    begin
      return true if NetAddr::validate_ip_addr(ip)
    rescue
      return false
    end
  end

  def self.address_used?(ip)
    return true if self.find_by_ip_address_packed(ip)
    return false
  end

  def up?
    return Net::Ping::External.new(ip_address).ping?
  end

  def self.AllPingable
    addresses=Ipv4Interface.find(:all)
    addresses.reject!{|a|a.is_stealth or a.is_reserved or a.is_virtual}
    addresses.reject!{|a|a.ipv4_subnet.subnet.is_stealth or a.ipv4_subnet.subnet.is_reserved or a.ipv4_subnet.subnet.is_local}
    return addresses
  end

  def self.PingAllPingable
    Ipv4Interface.AllPingable.each do |address|
      address.ping_count = 0 if address.ping_count.nil?
      if address.up?
        address.last_pinged_on = Time.now
        address.ping_count = address.ping_count + 1
      end
      address.save
    end
  end

  private

  def pack_address
    self.ip_address_packed = NetAddr::ip_to_i(self[:ip_address]) if !self[:ip_address].nil?
  end

  def set_subnet
    self.ipv4_subnet = Ipv4Subnet.find_by_address(self.ip_address) unless self.ipv4_subnet
  end

  def check_for_orphan
    if self.interface and self.interface.device
      device=self.interface.device
      if device.ipv4_interfaces_count == 0
        device.destroy
      end
    end
    return true
  end


end
