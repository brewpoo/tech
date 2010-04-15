class FixUpIpv4Scopes < ActiveRecord::Migration
  def self.up
    rename_column :ipv4_scopes, :zone_id, :ipv4_subnet_id
  end

  def self.down
    rename_column :ipv4_scopes, :ipv4_subnet_id, :zone_id
  end
end
