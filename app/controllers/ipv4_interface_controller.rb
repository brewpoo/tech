class Ipv4InterfaceController < ApplicationController

  active_scaffold :ipv4_interface do |config|
    actions.exclude :create, :update
    list.columns = [:owning_device, :interface, :ipv4_subnet, :ip_address] 
    show.columns = [:interface, :ipv4_subnet, :ip_address, :last_pinged_on, :ping_count, :created_on, :created_by]
    columns[:ipv4_subnet].form_ui = :select
    columns[:is_stealth].form_ui = :checkbox
    columns[:is_reserved].form_ui = :checkbox
    subform.columns = [:ip_address, :is_stealth, :is_reserved]
    list.sorting = {:ip_address => :asc }
    list.per_page = 50
    # Search and Sort
    columns[:ip_address].search_sql = 'ip_address'
    columns[:ip_address].sort_by :sql => 'ip_address_packed'
  end

end
