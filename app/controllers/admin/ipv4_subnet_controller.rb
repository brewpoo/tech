class Admin::Ipv4SubnetController < Admin::BaseController

  active_scaffold :ipv4_subnet do |config|
    list.columns = [:subnet, :parent, :subnet_address, :subnet_mask, :interface_count, :zone]
    show.columns = subform.columns = [:parent, :subnet_address, :subnet_mask]
    nested.add_link("Show Interfaces",[:ipv4_interfaces])
  end
end
