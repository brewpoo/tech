class EquipmentPropertyController < ApplicationController

  active_scaffold :equipment_property do |config|
    list.columns = [:full_name]
  end

end
