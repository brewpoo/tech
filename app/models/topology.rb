class Topology < ActiveRecord::Base

  acts_as_reportable

  include TreeFunctions

  acts_as_tree

  has_many :subnets
  has_many :interfaces

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => "parent_id"

  def to_label
    full_name
  end

  def self.map_select
    Topology.find(:all).map { |t| [t.to_label, t.id] }
  end

end
