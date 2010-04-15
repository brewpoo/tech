class RenameClusterTables < ActiveRecord::Migration
  def self.up
    rename_table :clusters, :host_clusters
    rename_table :cluster_types, :host_cluster_types
    rename_column :host_clusters, :cluster_type_id, :host_cluster_type_id
  end

  def self.down
  end
end
