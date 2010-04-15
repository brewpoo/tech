class Admin::Ipv4AssignmentController < Admin::BaseController

  active_scaffold :ipv4_assignment do |config|
    columns.add :subnet_title
    create.columns = update.columns = [:subnet_address, :prefix, :description, :network_class, :topology, :zone, :assign_prefix]
    list.columns = [:subnet_title, :description, :network_class, :topology, :assign_prefix]
    columns[:network_class].form_ui = :select
    columns[:topology].form_ui = :select
    columns[:zone].form_ui = :select
    columns[:subnet_title].label = 'Subnet'
    list.sorting = { :subnet_address_packed => :asc }
  end

end
