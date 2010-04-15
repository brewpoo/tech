class Admin::Ipv4InterfaceController < Admin::BaseController

  active_scaffold :ipv4_interface do |config|
    list.columns = [:ipv4_subnet, :device, :interface, :ip_address, :interface, :zone]
  end

end
