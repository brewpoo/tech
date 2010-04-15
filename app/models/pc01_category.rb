class Pc01Category < ActiveRecord::Base

  acts_as_reportable

  has_many :pc01_items
  belongs_to :order_type

  validates_presence_of :title
  validates_uniqueness_of :title

  validates_presence_of :order_type
  validates_associated :order_type

end
