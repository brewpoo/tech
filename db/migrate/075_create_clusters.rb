class CreateClusters < ActiveRecord::Migration
  def self.up
    create_table :clusters do |t|
      t.column :cluster_type_id, :integer
      t.column :hosting_device_id, :integer
      t.column :description, :string
    end
    create_table :clusters_devices do |t|
      t.column :cluster_id, :integer
      t.column :device_id, :integer
    end
  end

  def self.down
    drop_table :clusters
    drop_table :clusters_devices
  end
end
