class DeviceClass < ActiveRecord::Base
  include TreeFunctions

  acts_as_tree
  acts_as_reportable

  has_many :devices
  has_many :ipv4_schema_rules
  
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.select_map
    DeviceClass.find(:all,:order=>'name asc').map{|d|[d.name,d.id]}
  end

end
