class Admin::Ipv4AssignedNetworkController < Admin::BaseController

  active_scaffold :ipv4_assigned_network do |config|
    columns.add :subnet_title
    list.columns = [:subnet_title, :description]
    create.columns = update.columns = [:subnet_address, :prefix, :description]
    columns[:subnet_title].label = 'Subnet'
    list.sorting = { :subnet_address_packed => :asc }
  end

end
