class CreateVirtualHostTypes < ActiveRecord::Migration
  def self.up
    create_table :virtual_host_types do |t|
      t.column :name, :string
      t.column :description, :text 
    end
    add_column :ipv4_virtual_hosts, :virtual_host_type_id, :integer
    add_column :ipv4_virtual_hosts, :otherid, :integer
    add_index :ipv4_virtual_hosts, :virtual_host_type_id
  end

  def self.down
    drop_table :virtual_host_types
    remove_index :ipv4_virtual_hosts, :virtual_host_type_id
    remove_column :ipv4_virtual_hosts, :virtual_host_type_id
  end
end
