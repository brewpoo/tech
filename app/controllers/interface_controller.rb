class InterfaceController < ApplicationController

  active_scaffold :interface do |config|
    list.columns = create.columns = update.columns = [:name, :hardware_address, :topology, :vlanid, :ipv4_interfaces, :domain_names]
    subform.columns = [:name, :hardware_address, :topology]
    columns[:topology].form_ui=:select
    # Search and Sort
    columns[:ipv4_interfaces].search_sql = 'ipv4_interfaces.ip_address'
    columns[:ipv4_interfaces].sort_by :sql => 'ipv4_interfaces.ip_address_packed'
    columns[:topology].search_sql = 'topologies.name'
    columns[:topology].sort_by :sql => 'topologies.name'
    search.columns << [:ipv4_interfaces, :topology]
  end

end
