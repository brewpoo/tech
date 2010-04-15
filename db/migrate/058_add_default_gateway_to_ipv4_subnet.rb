class AddDefaultGatewayToIpv4Subnet < ActiveRecord::Migration
  def self.up
    add_column :ipv4_subnets, :default_gateway, :string
  end

  def self.down
  end
end
