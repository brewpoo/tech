class Ipv4VirtualHostController < ApplicationController

  active_scaffold :ipv4_virtual_host do |config|
    list.columns = [:ipv4_subnet, :description, :virtual_host_type, :ipv4_interface, :ipv4_virtual_host_interfaces]
    list.per_page = 50
    create.columns = update.columns = [:ipv4_subnet, :description, :virtual_host_type, :vrid, :otherid, :is_vrrp, :device_class, :ipv4_interface, :domain_names]
    show.columns = [:ipv4_subnet, :description, :vrid, :ipv4_interface, :ipv4_virtual_host_interfaces, :is_vrrp, :domain_names]
    columns[:ipv4_subnet].form_ui = :select
    columns[:virtual_host_type].form_ui = :select
    columns[:is_vrrp].form_ui = :checkbox
    columns[:is_vrrp].label = "VRRP?"
    columns[:ipv4_interface].label = "Virtual Interface"
    columns[:ipv4_virtual_host_interfaces].label = "Real Interfaces"
    nested.add_link("Real Interfaces", [:ipv4_virtual_host_interfaces])
    # Search and Sort
    columns[:ipv4_subnet].search_sql = 'ipv4_subnets.subnet_address'
    columns[:ipv4_subnet].sort_by :sql => 'ipv4_subnets.subnet_address_packed'
    columns[:ipv4_interface].search_sql = 'ipv4_interfaces.ip_address'
    columns[:ipv4_interface].sort_by :sql => 'ipv4_interfaces.ip_address_packed'
    search.columns << [:ipv4_subnet, :ipv4_interface]
    # Filters
    config.actions.add :list_filter
    config.list_filter.add(:association, :virtual_host_type, {:label => "Virtual Host Type", :association => [:virtual_host_type]})
  end

end
