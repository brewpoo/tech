class RemoveZoneFromIpv4Interface < ActiveRecord::Migration
  def self.up
    remove_column :ipv4_interfaces, :zone_id
  end

  def self.down
  end
end
