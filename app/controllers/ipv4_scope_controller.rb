class Ipv4ScopeController < ApplicationController

  active_scaffold :ipv4_scope do |config|
    list.columns = [:ipv4_subnet, :name, :server, :ipv4_address_ranges]
    show.columns = [:ipv4_subnet, :name, :description, :server, :ipv4_address_ranges, :ipv4_scope_option_entries]
    create.columns = update.columns = [:ipv4_subnet, :name, :description, :server, :ipv4_address_ranges, :ipv4_scope_option_entries]
    list.sorting = { :ipv4_subnet => :asc }
    list.per_page = 50
    columns[:ipv4_subnet].form_ui = :select
    columns[:server].form_ui = :select
    # Searching and Sorting
    columns[:ipv4_subnet].sort_by :sql => 'ipv4_subnets.subnet_address_packed'
    columns[:ipv4_subnet].search_sql = 'ipv4_subnets.subnet_address'
    search.columns << [:ipv4_subnet]
  end

end
