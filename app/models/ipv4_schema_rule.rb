class Ipv4SchemaRule < ActiveRecord::Base
  belongs_to :zone
  belongs_to :device_class

  before_validation :pack_address

  validates_presence_of :network_address
  validates_presence_of :network_mask

  validates_presence_of :device_class
  validates_associated :device_class

  validates_presence_of :ubound
  validates_presence_of :lbound

  validates_numericality_of :ubound, :only_integer => true
  validates_numericality_of :lbound, :only_integer => true

  def validate
    errors.add_to_base('ubound must be greater than or equal to lbound') if ubound<lbound
  end

  def pack_address
    self.network_address_packed = NetAddr::ip_to_i(self[:network_address]) if !self[:network_address].nil?
    self.network_mask_packed = NetAddr::ip_to_i(self[:network_mask]) if !self[:network_mask].nil?
  end

  def network_mask_bits
    NetAddr::i_to_ip(self[:network_mask_packed]) if !self[:network_mask].nil?
  end

  def network_description
    "#{network_address}/#{network_mask_bits}"
  end

  def range_description
    "#{lbound}-#{ubound}"
  end

  def to_label
    network_description
  end

  def this_network
    network_address_packed & network_mask_packed
  end

  def includes?(network)
    return (this_network == (network & network_mask_packed))
  end

  def device_class_includes?(dc)
    return true if dc == self.device_class
    return true if dc.ancestors.include? self.device_class
    return false
  end

end
