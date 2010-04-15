class CreateApplicationServers < ActiveRecord::Migration
  def self.up
    create_table :application_servers do |t|
      t.column :application_id, :integer
      t.column :server_id, :integer
      t.column :service_status_id, :integer
      t.column :service_id, :integer
    end
  end

  def self.down
    drop_table :application_servers
  end
end
