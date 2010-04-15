class Subnet < ActiveRecord::Base

  acts_as_reportable

  before_create :set_date_installed

  belongs_to :network_class
  belongs_to :topology
  has_one :ipv4_subnet, :dependent => :destroy
  has_many :ipv4_scopes, :through => :ipv4_subnet
  has_many :ipv4_interfaces, :through => :ipv4_subnet
  belongs_to :virtual_lan

  validates_date :date_installed, :allow_nil => true
  validates_presence_of :description
  validates_numericality_of :vlanid, :greater_than => 0, :less_than => 4096, :allow_nil => true 

  attr_accessor :vlan

  def to_label
    "#{ipv4_subnet.to_label if ipv4_subnet} - #{description}"
  end

  def vlan
    return "#{virtual_lan.vlanid}" if virtual_lan
    return "#{vlanid}"
  end

  def set_date_installed
    self.date_installed = Time.now
  end

  def Subnet.all_subnets
    Subnet.find(:all).sort_by{|s|s.ipv4_subnet.subnet_address_packed}.map{|s|["#{s.ipv4_subnet.to_label} [#{s.description}]",s.id]}
  end

  def self.select_map
    all_subnets = CACHE.get("all_subnets")
    if all_subnets == nil
      Subnet.run_precache
      all_subnets = CACHE.get("all_subnets")
    end
    return all_subnets
  rescue
    return Subnet.all_subnets
  end

  def self.run_precache
    CACHE.set("all_subnets",Subnet.all_subnets)
  end


end
