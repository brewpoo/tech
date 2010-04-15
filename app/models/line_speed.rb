class LineSpeed < ActiveRecord::Base
  include TreeFunctions

  acts_as_reportable

  acts_as_tree :order => 'name'

  has_many :circuits

  validates_presence_of :name
  validates_presence_of :speed

  validates_uniqueness_of :name, :scope => 'parent_id'

  def to_label
    "#{name} (#{speed})"
  end

end
