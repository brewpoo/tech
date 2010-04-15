class CreateServers < ActiveRecord::Migration
  def self.up
    create_table :servers do |t|
      t.column :device_id, :integer
      t.column :primary_engineer_id, :integer
      t.column :is_san_connected, :boolean
      t.column :is_tivoli_agent, :boolean
      t.column :description, :text
    end
  end

  def self.down
    drop_table :servers
  end
end
