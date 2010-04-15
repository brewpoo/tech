class EquipmentProperty < ActiveRecord::Base

  belongs_to :equipment
  belongs_to :property

  validates_presence_of :value

  def full_name
    "#{property.name}: #{value} #{property.unit}"
  end

end
