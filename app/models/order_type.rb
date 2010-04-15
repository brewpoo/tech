class OrderType < ActiveRecord::Base

  acts_as_reportable

  belongs_to :processor,
    :class_name => "User",
    :foreign_key => "processor_id"
  has_many :pc01_categories

  validates_presence_of :name
  validates_uniqueness_of :name

  validates_associated :processor

  def to_label
    "#{name}"
  end

  def OrderType.select 
    OrderType.find(:all).sort_by{|n| n.name}.map{|n|[n.name,n.id]}
  end

end
