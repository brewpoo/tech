class Zone < ActiveRecord::Base
  include TreeFunctions
  acts_as_tree :order => 'name'

  has_many :ipv4_schema_rules

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => "parent_id"

  def to_label
    "#{name}"
  end

  def default?
    return false unless self == Zone.find(:first)
    return true
  end

end
