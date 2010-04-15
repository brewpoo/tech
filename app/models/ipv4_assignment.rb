class Ipv4Assignment < ActiveRecord::Base

  before_validation :pack_address

  belongs_to :zone
  belongs_to :network_class
  belongs_to :topology

  validates_presence_of :subnet_address
  validates_numericality_of :subnet_address_packed
  validates_presence_of :prefix
  validates_numericality_of :prefix
  validates_presence_of :assign_prefix
  validates_numericality_of :assign_prefix

  validates_presence_of :network_class_id
  validates_associated :network_class
  validates_presence_of :topology_id
  validates_associated :topology

  def pack_address
    self.subnet_address_packed = NetAddr::ip_to_i(self.subnet_address) if !self.subnet_address.nil?
  end

  def subnet_title
    "#{subnet_address}/#{prefix}"
  end

  def self.next_subnet(network_class,topology=nil,zone=nil)
    cond = Caboose::EZ::Condition.new :ipv4_assignments do
      network_class_id == network_class.id
      topology_id == topology.id unless topology.nil?
      zone_id == zone_id unless zone.nil?
      topology_id == nil unless !topology.nil?
      zone_id == nil unless !zone.nil?
    end
    assignments=Ipv4Assignment.find(:all, :conditions => cond.to_sql)
    assignments.each do |group|
      netid = group.subnet_address_packed
      assign_mask = NetAddr::bits_to_mask(group.assign_prefix,4)
      group_mask = NetAddr::bits_to_mask(group.prefix,4)
      while (netid & group_mask) == group.subnet_address_packed do 
        if Ipv4Subnet.any_overlap?({:network => netid, :mask => assign_mask})
          netid = netid + 2**(32-group.assign_prefix)
        else
          # Found a non-overlapping address
          return Ipv4Subnet.new(:subnet_address => NetAddr::i_to_ip(netid), :subnet_mask => NetAddr::i_to_ip(assign_mask))
        end
      end
    end
    return false
  end

end
