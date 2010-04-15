class Ipv4AddressHold < ActiveRecord::Base

  before_validation :clean_out_expired_holds
  before_save :set_held_on

  belongs_to :ipv4_subnet

  validates_presence_of :ip_address_packed
  validates_uniqueness_of :ip_address_packed

  def set_held_on
    self.held_on = Time.now
  end

  def clean_out_expired_holds
    Ipv4AddressHold.delete_all(["held_on < ?", Time.now - 10.minutes])
  end

  def self.exists?(address)
    Ipv4AddressHold.delete_all(["held_on < ?", Time.now - 10.minutes])
    return true if Ipv4AddressHold.find(:first, :conditions => ["ip_address_packed = ?", address])
    return false
  end

  def to_label
    "#{NetAddr::i_to_ip(ip_address_packed)}"
  end

  def self.remove_hold(address)
    Ipv4AdressHold.find_by_ip_address_packed(NetAddr::ip_to_i(address)).destroy
  end

end
