class Property < ActiveRecord::Base
  
  has_many :product_properties
  has_many :equipment_properties

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :unit

  def to_label 
    "#{name} (#{unit})"
  end

end
