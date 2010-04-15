class Architecture < ActiveRecord::Base
  include TreeFunctions

  acts_as_tree

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => "parent_id"

  def to_label
    full_name
  end

end
