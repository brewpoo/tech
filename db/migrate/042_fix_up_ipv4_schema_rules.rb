class FixUpIpv4SchemaRules < ActiveRecord::Migration
  def self.up
    rename_column :ipv4_schema_rules, :net_address, :network_address_packed
    rename_column :ipv4_schema_rules, :net_mask, :network_mask_packed
    add_column :ipv4_schema_rules, :network_address, :string
    add_column :ipv4_schema_rules, :network_mask, :string
    
  end

  def self.down
  end
end
