class PrepForIpMigration < ActiveRecord::Migration
  def self.up
    #add_column :ipv4_subnets, :old_network_id, :integer
    #add_column :devices, :old_host_id, :integer
    #add_column :device_classes, :old_hostclass_id, :integer
    #add_column :network_classes, :old_netclass_id, :integer
    #add_column :topologies, :old_topology_id, :integer
    #rename_column :ipv4_virtual_hosts, :interface_id, :ipv4_interface_id
    add_column :ipv4_virtual_hosts, :is_vrrp, :boolean
  end

  def self.down
  end
end
