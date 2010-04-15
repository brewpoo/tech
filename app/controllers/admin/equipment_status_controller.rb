class Admin::EquipmentStatusController < Admin::BaseController

  active_scaffold :equipment_status do |config|
    list.columns = [:name, :description]
    update.columns = create.columns = [:name, :description, :flag]
    subform.columns = [:name]
  end

end
