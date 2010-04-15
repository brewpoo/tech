class Ipv4SubnetController < ApplicationController

  active_scaffold :ipv4_subnet do |config|
    show.columns = [:subnet_address, :subnet_mask, :gateway_address, :zone, :usage, :ipv4_scopes]
    subform.columns = [:subnet_address, :subnet_mask, :gateway_address]
  end

end
