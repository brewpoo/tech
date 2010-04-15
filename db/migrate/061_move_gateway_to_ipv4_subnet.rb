class MoveGatewayToIpv4Subnet < ActiveRecord::Migration
  def self.up
    #remove_column :ipv4_scopes, :gateway_id
    add_column :ipv4_subnets, :gateway_address, :string
  end

  def self.down
  end
end
