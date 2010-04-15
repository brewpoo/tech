class FixUpIpVirtualHostInterfaces < ActiveRecord::Migration
  def self.up
    drop_table :ipv4_virtual_interfaces
    create_table "ipv4_virtual_host_interfaces" do |t|
      t.column :ipv4_virtual_host_id, :integer
      t.column :ipv4_interface_id, :integer
      t.column :priority, :integer
    end
  end

  def self.down
  end
end
