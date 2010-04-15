class Ipv4VirtualHostInterfaceController < ApplicationController
  
  active_scaffold :ipv4_virtual_host_interface do |config|
    list.columns = [:owning_device, :ipv4_interface, :priority]
    create.columns = update.columns = [:ipv4_interface, :priority]
  end

end
