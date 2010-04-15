class Department < ActiveRecord::Base
  include TreeFunctions
  acts_as_tree :order => 'name'
  acts_as_reportable

  has_many :contacts
  belongs_to :company

  validates_presence_of :name
  validates_uniqueness_of :name

  def to_label
    "#{name}"
  end

  def Department.select
    Department.find(:all, :order => 'name').map { |d| [d.name, d.id] }
  end

end
