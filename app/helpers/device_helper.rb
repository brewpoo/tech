module DeviceHelper

  def device_class_form_column(record,input_name)
    selected = record.device_class ? record.device_class.id : nil
    select :record, :device_class, tree_select_map(DeviceClass.find(:all,:conditions=>'parent_id is null',:order=>'name'),0),
        :name => input_name, :selected => selected
  end


end
