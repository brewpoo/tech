class Ipv4VirtualHost < ActiveRecord::Base

  before_create     :build_virtual_device
  before_update     :update_virtual_device
  before_save       :set_interface_subnet
  after_destroy    :purge_virtual_device

  belongs_to :ipv4_subnet
  belongs_to :ipv4_interface
  belongs_to :virtual_host_type
  has_many :ipv4_virtual_host_interfaces, :dependent => :destroy 
  has_many :ipv4_interfaces, :through => :ipv4_virtual_host_interfaces
  has_many :domain_names, :as => :nameable, :dependent => :destroy

  validates_uniqueness_of :vrid, :scope => 'ipv4_subnet_id'
  validates_presence_of :vrid, :if => Proc.new { |vh| vh.is_vrrp? }
  validates_presence_of :description
  validates_presence_of :ipv4_interface
  validates_presence_of :ipv4_subnet

  attr_accessor :device_class


  def set_interface_subnet
    self.ipv4_interface.ipv4_subnet = self.ipv4_subnet
    self.ipv4_interface.is_virtual = true
  end

  def to_label
    "#{ipv4_subnet.to_label} #{description} (VRID:#{vrid})"
  end

  def forward_entry
    return nil if domain_names.empty?
    address = ipv4_interface.ip_address
    return false unless Ipv4Interface.valid_address? address
    return "#{domain_names.first.name}  IN  A #{address}\n"
  end

  def reverse_entry
    return nil if domain_names.empty?
    return "#{ipv4_interface.octet(4)}.#{ipv4_interface.octet(3)}\tPTR\t#{domain_names.first.fqdn}.\n"
  end


  private

  def set_virtual
    self.ipv4_interface.is_virtual = true
  end

  def build_virtual_device
    ipv4_interface.interface = Interface.new
    ipv4_interface.interface.device = Device.new(:hostname=>"vh_#{ipv4_interface.ip_address}",:description=>description,:is_virtual=>true,:device_class=>DeviceClass.find(device_class))
    ipv4_interface.save
  end

  def update_virtual_device
    ipv4_interface.interface.device.update_attributes(:device_class => DeviceClass.find(device_class),
      :hostname=>"vh_#{ipv4_interface.ip_address}",:description=>description,:is_virtual=>true)
  end

  def purge_virtual_device
    return true unless ipv4_interface.interface
    ipv4_interface.interface.device.destroy
  end

end
