class Interface < ActiveRecord::Base

  acts_as_reportable
  
  belongs_to :device
  belongs_to :topology

  has_many :ipv4_interfaces, :dependent => :destroy
  #has_many :ipv4_virtual_host_interfaces
  #has_one :wireless_interface
  #
  has_many :domain_names, :as => :nameable, :dependent => :destroy

  before_validation :clean_up_hardware_address

  validates_format_of :hardware_address, :with => /[0-9a-f]{12}/, :allow_nil => true
  validates_uniqueness_of :hardware_address, :allow_nil => true
  #validates_uniqueness_of :name, :scope => 'device_id'

  validates_numericality_of :vlanid, :allow_nil => true

  def to_label
    label=""
    label += "#{name} " unless name.blank?
    label += "#{topology.name} " if self.topology
    label += "(#{hardware_address})" unless hardware_address.blank?
    return label
  end

  def device_label  
    "#{device.to_label if device} #{ipv4_interfaces[0].to_label if ipv4_interfaces}"
  end

  def main_ip_address
    return nil unless ipv4_interfaces
    return ipv4_interfaces[0]
  end


  def forward_entry
    return nil if domain_names.empty?
    return nil unless ipv4_interfaces
    address = main_ip_address.ip_address
    return false unless Ipv4Interface.valid_address? address
    return "#{domain_names.first.name}  IN  A #{address}\n"
  end

  def reverse_entry
    return unless ipv4_interfaces
    address = main_ip_address
    if domain_names
      return "#{address.octet(4)}.#{address.octet(3)}\tPTR\t#{domain_name.first.fqdn}.\n"
    elsif name and name.length > 0
      temp = name.gsub(/\W/, "-").gsub('_', '-').downcase
      if temp.match(/^\W/)
        temp = temp.slice[1..temp.length] 
      end
      return "#{address.octet(4)}.#{address.octet(3)}\tPTR\t#{temp}-#{device.fqdn}.\n"
    else
      return "#{address.octet(4)}.#{address.octet(3)}\tPTR\t#{device.fqdn}.\n"
    end
  end

  protected 

  def clean_up_hardware_address
    self.hardware_address = self.hardware_address.downcase.delete(":").delete("-") unless self.hardware_address.nil?
  end

end
