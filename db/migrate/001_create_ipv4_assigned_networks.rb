class CreateIpv4AssignedNetworks < ActiveRecord::Migration
  def self.up
    create_table :ipv4_assigned_networks do |t|
      t.column :subnet_address, :string
      t.column :subnet_address_packed, :integer, :limit => 8
      t.column :prefix, :integer
      t.column :description, :text
    end
  end

  def self.down
    drop_table :ipv4_assigned_networks
  end
end
