class Ipv4AssignedNetwork < ActiveRecord::Base

  before_validation :pack_address

  validates_presence_of :subnet_address
  validates_numericality_of :subnet_address_packed
  validates_presence_of :prefix
  validates_numericality_of :prefix

  def pack_address
    self.subnet_address_packed = NetAddr::ip_to_i(self.subnet_address) if !self.subnet_address.nil?
  end

  def subnet_title
    "#{subnet_address}/#{prefix}"
  end

  def netid
    subnet_address_packed & netmask
  end

  def netmask
    NetAddr::bits_to_mask(prefix,4)
  end

  def Ipv4AssignedNetwork.includes? (address)
    if address.kind_of? Ipv4Subnet
    elsif address.kind_of? Bignum
      Ipv4AssignedNetwork.find(:all).each do |network|
        return true if (address & network.netmask) == network.netid
      end
    end
    return false
  end
  
end
