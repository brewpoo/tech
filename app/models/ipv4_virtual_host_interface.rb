class Ipv4VirtualHostInterface < ActiveRecord::Base

  belongs_to :ipv4_virtual_host
  belongs_to :ipv4_interface

  validates_numericality_of :priority, :greater_than => 0, :less_than => 256

  def to_label
    return nil unless ipv4_interface
    "#{ipv4_interface.interface.device.hostname if ipv4_interface.interface} [#{ipv4_interface.ip_address}] (#{priority})"
  end

  def validate
    errors.add_to_base("IP address must exist on same subnet as virtual host") unless ipv4_virtual_host.ipv4_subnet.includes? ipv4_interface.ip_address
  end

  def owning_device
    ipv4_interface.interface.device.to_label
  end

end
