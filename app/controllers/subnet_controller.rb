class SubnetController < ApplicationController

  before_filter :setup_active_scaffold
  
  active_scaffold :subnet do |config|
    columns.add :vlan
    list.columns = [:ipv4_subnet, :description, :network_class, :topology, :vlan, :ipv4_scopes]
    create.columns = update.columns = [:ipv4_subnet, :virtual_lan, :vlanid, :description, :network_class, :topology, 
      :date_installed, :is_delinquent, :is_local, :is_private, :is_reserved, :is_stealth]
    list.sorting = {:ipv4_subnet => :asc }
    list.per_page = 50
    columns[:network_class].form_ui = :select
    columns[:topology].form_ui = :select
    columns[:is_delinquent].form_ui = :checkbox
    columns[:is_local].form_ui = :checkbox
    columns[:is_private].form_ui = :checkbox
    columns[:is_reserved].form_ui = :checkbox
    columns[:is_stealth].form_ui = :checkbox
    columns[:vlanid].label = 'Non-Unique VLAN ID'
    columns[:ipv4_scopes].label = "IPv4 DHCP Scopes"
    columns[:ipv4_subnet].label = "IPv4 Subnet"
    nested.add_link("Addresses", [:ipv4_interfaces])
    nested.add_link("Scopes", [:ipv4_scopes])
    # Searching and sorting
    columns[:ipv4_subnet].sort_by :sql => 'ipv4_subnets.subnet_address_packed'
    columns[:ipv4_subnet].search_sql = "ipv4_subnets.subnet_address"
    columns[:vlan].sort_by :method => 'vlan.to_i'
    search.columns << [:ipv4_subnet]
    
    # Filtering
    config.actions.add :list_filter
    config.list_filter.add(:association, :network_class, {:label => "Network Class", :association => [:network_class]})
    config.list_filter.add(:association, :topology, {:label => "Topology", :association => [ :topology ] })
  end

  def setup_active_scaffold
    if this_user.has_role?('network_administrator')
      active_scaffold_config.action_links.add('request_new',:label => 'Create by Wizard', :type => :table,
        :crud_type => :create, :inline => false)
    else
      active_scaffold_config.actions.exclude('request_new')
    end
  end

  def request_new
    @network_classes=NetworkClass.map_select
    @topologies=Topology.map_select
  end

  def request_step2
    redirect_to :back and return if params[:network_class][:id].empty? or params[:topology][:id].empty?
    @topology=Topology.find(params[:topology][:id].to_i)
    @network_class=NetworkClass.find(params[:network_class][:id].to_i)
    @ipv4_subnet=Ipv4Assignment.next_subnet(@network_class,@topology) || Ipv4Subnet.new
  end

  def request_create
    subnet=Subnet.new(params[:subnet])
    subnet.topology=Topology.find(params[:topology][:id].to_i)
    subnet.network_class=NetworkClass.find(params[:network_class][:id].to_i)
    subnet.build_ipv4_subnet(params[:ipv4_subnet])
    subnet.save
    redirect_to :action => 'list'
  end

end
