class RemoveDefaultGatewayFromIpv4Subnets < ActiveRecord::Migration
  def self.up
    remove_column :ipv4_subnets, :default_gateway
  end

  def self.down
  end
end
