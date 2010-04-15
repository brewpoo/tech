class LineType < ActiveRecord::Base
  include TreeFunctions

  acts_as_reportable

  acts_as_tree

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => "parent_id"

  def to_label
    name
  end

end
