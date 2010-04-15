class ServerController < ApplicationController

  active_scaffold :server do |config|
    list.columns = [:hostname, :fqdn, :description, :operating_system, :primary_engineer, :ipv4_interfaces]
    create.columns = update.columns = [:device, :hostname, :domain_names, :description, :operating_system, :primary_engineer, :equipment, :application_servers, :is_san_connected, :is_tivoli_agent]
    show.columns = [:device, :fqdn, :hostname, :description, :primary_interface, :interfaces, :operating_system, :primary_engineer, :links]
    columns[:device].form_ui = :select
    columns[:device].label = "Hosted on"
    columns[:device].description = "Used for VMs, Zones, etc"
    columns[:primary_engineer].form_ui = :select
    columns[:operating_system].form_ui = :select
    columns[:is_san_connected].form_ui = :checkbox
    columns[:is_san_connected].label = "SAN Attached?"
    columns[:is_tivoli_agent].form_ui = :checkbox
    columns[:is_tivoli_agent].label = "Tivoli Agent?"
    list.sorting = {:hostname => :asc}
    list.per_page = 50
    nested.add_link("Applications", [:application_servers])
    # Sorting and Searching
    columns[:primary_engineer].sort_by :sql => 'contacts.last_name'
    columns[:primary_engineer].search_sql = 'contacts.last_name'
    columns[:operating_system].sort_by :sql => 'operating_systems.long_name'
    columns[:operating_system].search_sql = 'operating_systems.long_name'
    columns[:equipment].sort_by :sql => 'equipment.serial_number'
    columns[:equipment].search_sql = 'equipment.serial_number'
    columns[:interfaces].includes = [:ipv4_interfaces]
    columns[:ipv4_interfaces].search_sql = 'ipv4_interfaces.ip_address'
    columns[:ipv4_interfaces].sort_by :sql => 'ipv4_interfaces.ip_address_packed'
    search.columns << [:operating_system, :primary_engineer, :equipment, :ipv4_interfaces]
    # Filters 
    config.actions.add :list_filter
    config.list_filter.add(:treeassociation, :operating_system, {:label => "Operating System", :association => [:operating_system]})
  end

  def all_server_devices
    return unless request.xhr?
    @devices = Device.server_devices
    render_js
  end

  def all_devices
    return unless request.xhr?
    @devices = Device.all_devices
    render_js
  end


end
