class AddOldInterfaceId < ActiveRecord::Migration
  def self.up
    add_column :ipv4_interfaces, :old_interface_id, :integer
  end

  def self.down
  end
end
