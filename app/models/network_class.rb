class NetworkClass < ActiveRecord::Base

  acts_as_reportable

  include TreeFunctions

  acts_as_tree

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => "parent_id"

  def to_label
    full_name
  end

  def self.map_select
    NetworkClass.find(:all, :order => "name").map { |n| [n.to_label, n.id] }
  end

end
