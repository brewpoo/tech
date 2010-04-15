class MoveDomainEntry < ActiveRecord::Migration
  def self.up
    add_column :domain_entries, :ipv4_interface_id, :integer
    add_column :devices, :primary_interface_id, :integer
    remove_column :domain_entries, :doman_entry_type_id
    drop_table :domain_entry_types
    add_column :domain_entries, :is_forward, :boolean
    add_column :domain_entries, :is_reverse, :boolean
    create_table :domains_servers do |t|
      t.column :domain_id, :integer
      t.column :server_id, :integer
    end
  end

  def self.down
  end
end
