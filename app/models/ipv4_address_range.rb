class Ipv4AddressRange < ActiveRecord::Base

  before_save :pack_address
  belongs_to :ipv4_scope

  validates_presence_of :start_address
  validates_presence_of :end_address
  validates_format_of :start_address, :with => /\A(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)(?:\.(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)){3}\z/
  validates_format_of :end_address, :with => /\A(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)(?:\.(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)){3}\z/

  def pack_address
    self.start_address_packed = NetAddr::ip_to_i(self[:start_address]) if !self[:start_address].nil?
    self.end_address_packed = NetAddr::ip_to_i(self[:end_address]) if !self[:end_address].nil?
  end

  def validate
    errors.add_to_base('Invalid start IP Address for subnet') unless ipv4_scope.ipv4_subnet.includes? start_address
    errors.add_to_base('Invalid end IP Address for subnet') unless ipv4_scope.ipv4_subnet.includes? end_address
  end

  def to_label
    "#{start_address}-#{end_address}"
  end

end
