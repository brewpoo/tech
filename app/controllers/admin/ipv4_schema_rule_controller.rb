class Admin::Ipv4SchemaRuleController < Admin::BaseController

  active_scaffold :ipv4_schema_rule do |config|
    columns.add :network_description, :range_description
    list.columns = [:zone, :network_description, :range_description, :device_class, :description]
    create.columns = update.columns = [:zone, :network_address, :network_mask, :description, :device_class,
      :lbound, :ubound]
    columns[:device_class].form_ui = :select
    columns[:zone].form_ui = :select
    list.sorting = { :network_address_packed => :asc } 
    list.per_page = 50
  end

end
