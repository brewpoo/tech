class Admin::SubnetController < Admin::BaseController

  active_scaffold :subnet do |config|
    list.sorting = {:ipv4_subnet => 'ASC'}
    columns[:description].inplace_edit=true
    columns[:is_delinquent].label="Delinquent?"
    columns[:is_delinquent].form_ui=:checkbox
    columns[:is_reserved].label="Reserved?"
    columns[:is_reserved].form_ui=:checkbox
    columns[:is_stealth].label="Stealth?"
    columns[:is_stealth].form_ui=:checkbox
    columns[:network_class].form_ui = :select
    columns[:topology].form_ui = :select
    columns[:ipv4_subnet].label="IPv4 Subnet"
    columns[:ipv4_subnet].sort_by :sql => "ipv4_subnets.subnet_address_packed"
    
  end

end
