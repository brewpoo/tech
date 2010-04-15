module Ipv4VirtualHostHelper

  def device_class_form_column(record,input_name)
    if record.new_record?
      selected = nil
    else
      selected = record.ipv4_interface.interface.device.device_class.id
    end
    select :record, :device_class, tree_select_map(DeviceClass.find(:all,:conditions=>'parent_id is null',:order=>'name'),0),
        :name => input_name, :selected => selected
  end

  def ipv4_subnet_form_column(record,input_name)
    selected = record.ipv4_subnet_id || nil
    select :record, :ipv4_subnet, Ipv4Subnet.select_map, :name => input_name, :selected => selected
  end

end
