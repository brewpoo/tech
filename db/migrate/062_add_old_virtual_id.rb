class AddOldVirtualId < ActiveRecord::Migration
  def self.up
    add_column :ipv4_virtual_hosts, :old_virtual_id, :integer
  end

  def self.down
  end
end