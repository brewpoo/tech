class AddStiTypeToDevices < ActiveRecord::Migration
  def self.up
    add_column :devices, :type, :string
    add_column :devices, :primary_engineer_id, :integer
    add_column :devices, :is_san_connected, :boolean
    add_column :devices, :is_tivoli_agent, :boolean
    add_column :device_classes, :set_type, :string
    add_column :devices, :operating_system_id, :integer
    drop_table :servers
    drop_table :printers
    drop_table :employers
    drop_table :host_clusters
    drop_table :host_cluster_types
    drop_table :devices_host_clusters
    drop_table :domain_entries
    rename_table :applications, :apps
  end

  def self.down
    remove_column :devices, :type
    remove_column :devices, :primary_engineer_id
    remove_column :devices, :is_san_connected
    remove_column :devices, :is_tivoli_agent
    remove_column :device_classes, :type
    remove_column :devices, :operating_system_id
  end
end
