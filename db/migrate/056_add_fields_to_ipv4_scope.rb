class AddFieldsToIpv4Scope < ActiveRecord::Migration
  def self.up
    add_column :ipv4_scopes, :server_id, :integer
  end

  def self.down
  end
end
