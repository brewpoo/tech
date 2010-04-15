class Admin::EquipmentController < Admin::BaseController

  active_scaffold :equipment do |config|
    list.columns = [:product_full_name, :device, :equipment_status, :parent, :location, :serial_number, :tag_number]
    columns[:parent].form_ui = :select
    columns[:device].form_ui = :select
    columns[:equipment_status].form_ui = :select
    update.columns = create.columns =  [:product, :device, :equipment_status, 
      :parent, :location, :serial_number, :tag_number, :host_identifier, :delivery_date, :count]
  end

end
