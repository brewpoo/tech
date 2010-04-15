class Ipv4Subnet < ActiveRecord::Base
  
  acts_as_reportable

  acts_as_tree :order => 'subnet_address_packed'

  before_validation :pack_address
  
  belongs_to :zone
  belongs_to :subnet
  has_many :ipv4_interfaces, :dependent => :destroy
  has_many :ipv4_scopes, :dependent => :destroy
  has_many :ipv4_address_holds, :dependent => :destroy

  validates_presence_of :subnet_address
  validates_presence_of :subnet_mask

  validates_uniqueness_of :subnet_address, :scope => "subnet_mask"
  validates_uniqueness_of :subnet_address, :scope => "parent_id"
  validates_uniqueness_of :subnet_address, :scope => "zone_id"

  def self.select_map
    Ipv4Subnet.find(:all).sort_by{|s|s.subnet_address_packed}.map{|s|[s.subnet.to_label,s.id]}
  end

  def reverse_name
    subnet_address.split(/\.\w+\.\w+$/)[0]
  end

  def validate
    errors.add_to_base("Subnet address is not correct") unless this_network == subnet_address_packed
    errors.add_to_base("Invalid subnet mask") unless valid_mask?(subnet_mask)
    errors.add_to_base("Gateway address must exist on subnet") unless gateway_address.nil? or self.includes? gateway_address
    errors.add_to_base("Subnet address not assigned for use") unless Ipv4AssignedNetwork.includes? subnet_address_packed
  end

  def pack_address
    self.subnet_address_packed = NetAddr::ip_to_i(self[:subnet_address]) if !self[:subnet_address].nil?
    self.subnet_mask_packed = NetAddr::ip_to_i(self[:subnet_mask]) if !self[:subnet_mask].nil?
    self.zone=Zone.find(:first) unless self.zone
  end

  def subnet_mask_bits
    NetAddr::mask_to_bits(self[:subnet_mask_packed]) if !self[:subnet_mask_packed].nil?
  end

  def subnet_mask_long
    NetAddr::i_to_ip(self[:subnet_mask_packed]) if !self[:subnet_mask_packed].nil?
  end

  def to_label
    label = "#{subnet_address}/#{subnet_mask_bits}"
    #label << " (#{zone.name})" unless zone.default?
    return label
  end

  def report_label
    return "#{to_label} - #{subnet.description}"
  end
  

  def first_address
    subnet_address_packed + 1
  end

  def last_address
    subnet_address_packed + host_capacity
  end

  def address_range
    "#{first_address}-#{last_address}"
  end

  def address_used?(packed_address)
    return false if available_addresses.include? packed_address
    return true
  end

  def available_addresses
    available=(first_address..last_address).to_a
    ipv4_interfaces.each do |i|
      available.reject! { |a| a == i.ip_address_packed}
    end
    ipv4_scopes.each do |scope|
      scope.ipv4_address_ranges.each do |range|
        available.reject! { |a| (range.start_address_packed..range.end_address_packed).include? a}
      end
    end
    ipv4_address_holds.each do |hold|
      available.reject! { |a| a == hold.ip_address_packed }
    end
    return available 
  end

  def next_address(device_class,zone=nil)
    preferred = []
    available = []
    if subnet.is_delinquent?
      available << available_addresses
    else
      cond = Caboose::EZ::Condition.new :ipv4_schema_rules do
        zone_id == zone_id unless zone.nil?
        zone_id == :null unless !zone.nil?
      end
      Ipv4SchemaRule.find(:all).each do |rule|
        next unless rule.device_class_includes? device_class
        next unless rule.includes? subnet_address_packed
        preferred << ((this_network+rule.lbound)..(this_network+rule.ubound)).to_a if rule.device_class == device_class
        available << ((this_network+rule.lbound)..(this_network+rule.ubound)).to_a if rule.device_class_includes? device_class
      end
      return false if available.empty?
    end
    [preferred,available].each do |range|
      next if range.empty?
      # Clean up invalid addresses caused by bad lbound/ubounds
      range.flatten!.reject{|a| !includes? a}
      (range & available_addresses).each do |a|
        if Net::Ping::External.new(NetAddr::i_to_ip(a)).ping?
          create_rogue(a)
        else
          return a
        end
      end
    end
    return false
  end

  def get_and_hold_next_address(device_class,zone=nil)
    address = next_address(device_class,zone)
    return false if address.nil? or address==0
    ipv4_address_holds << Ipv4AddressHold.create(:ip_address_packed => address) 
    return address
  end

  def create_rogue(packed_address)
    address=NetAddr.i_to_ip(packed_address)
    device=Device.create(:device_class=>DeviceClass.find_by_name('Unknown'), :hostname=>"rogue_#{address}")
    interface=Interface.create(:device=>device,:name=>"rogue interface")
    Ipv4Interface.create(:ipv4_subnet=>self,:interface=>interface,:ip_address=>address,:is_rogue=>true)
  end

  def interface_count
    ipv4_interfaces_count
  end

  def host_capacity
    2**(32-NetAddr::mask_to_bits(subnet_mask_packed))-2
  end

  def reserved_count
    count = 0
    ipv4_scopes.each do |scope|
      scope.ipv4_address_ranges.each do |range|    
        count += range.end_address_packed - range.start_address_packed + 1
      end
    end
    return count
  end

  def free_capacity
    host_capacity - interface_count - reserved_count
  end

  def free_percentage
    return ((available_addresses.length.to_f/host_capacity.to_f)*1000).round/10
  end

  def this_network
    subnet_address_packed & subnet_mask_packed
  end

  def includes?(address)
    if address.class == String
      return true if (NetAddr::ip_to_i(address) & subnet_mask_packed) == this_network
    else
      return true if (address & subnet_mask_packed) == this_network
    end
    return false
  end

  def usage
    "#{free_percentage}% Free (#{interface_count}+#{reserved_count}/#{host_capacity})"
  end

  def up?
    return Net::Ping::External.new(gateway_address).ping? unless gateway_address.blank?
    return Net::Ping::External.new(ipv4_interfaces.find(:first).ip_address).ping? unless ipv4_interfaces.empty?
    return false
  end

  def self.any_overlap?(net)
    a_net = net[:network] #NetAddr::ip_to_i(net[:network])
    a_mask = net[:mask] #NetAddr::ip_to_i(net[:mask])
    Ipv4Subnet.find(:all).each do |b|
      return true if (a_net & b.subnet_mask_packed) == (b.subnet_address_packed & a_mask)
    end
    return false
  end

  def valid_mask?(netmask_str)
    netmask=NetAddr::ip_to_i(netmask_str)
    hostmask = 1
    all_f = 2**32-1

    32.times do
      check = netmask & hostmask
      if ( check != 0)
        hostmask = hostmask >> 1
        unless ( (netmask ^ hostmask) == all_f)
                   return false
              end
              break
      else
        hostmask = hostmask << 1
        hostmask = hostmask | 1
      end
    end
    return true
  end

  def self.find_by_address(address)
    packed = NetAddr::ip_to_i(address)
    Ipv4Subnet.find(:all).each do |s|
      return s if (packed & s.subnet_mask_packed) == (s.subnet_address_packed & s.subnet_mask_packed)
    end
    return false
  end

end
