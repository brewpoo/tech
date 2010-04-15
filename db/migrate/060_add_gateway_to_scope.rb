class AddGatewayToScope < ActiveRecord::Migration
  def self.up
    add_column :ipv4_scopes, :gateway_id, :integer
  end

  def self.down
  end
end
