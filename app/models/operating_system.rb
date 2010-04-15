class OperatingSystem < ActiveRecord::Base

  acts_as_reportable

  include TreeFunctions

  before_validation :set_long_name

  acts_as_tree

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => "parent_id"

  def to_label
    long_name
  end

  def set_long_name
    self.long_name=full_name(" ")
  end
  

end
