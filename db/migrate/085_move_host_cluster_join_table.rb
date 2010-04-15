class MoveHostClusterJoinTable < ActiveRecord::Migration
  def self.up
    rename_table :clusters_devices, :devices_host_clusters
    rename_column :devices_host_clusters, :cluster_id, :host_cluster_id
  end

  def self.down
  end
end
