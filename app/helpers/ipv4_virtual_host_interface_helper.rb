module Ipv4VirtualHostInterfaceHelper

  def ipv4_interface_form_column(record,input_name)
    if record.new_record?
      selected = nil
    else
      selected = record.ipv4_interface.id
    end
    select :record, :ipv4_interface, 
      record.ipv4_virtual_host.ipv4_subnet.ipv4_interfaces.reject{|i|i.is_virtual}.sort_by{|i|i.ip_address_packed}.map{|i|["#{i.to_label} (#{i.owning_device})",i.id]},
      :name => input_name, :selected => selected
  end

end
