class Admin::InterfaceController < Admin::BaseController

  active_scaffold :interface do |config|
    list.columns = show.columns = [:topology, :hardware_address, :name, :vlanid, :ipv4_interfaces]
  end

end
