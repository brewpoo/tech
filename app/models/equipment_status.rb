class EquipmentStatus < ActiveRecord::Base

  has_many :equipment

  def EquipmentStatus.select_map
    EquipmentStatus.find(:all).map{|e| [e.name,e.id]}
  end 

end
