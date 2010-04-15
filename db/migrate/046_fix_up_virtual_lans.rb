class FixUpVirtualLans < ActiveRecord::Migration
  def self.up
    remove_column :virtual_lans, :subnet_id
    add_column :subnets, :virtual_lan_id, :integer
  end

  def self.down
  end
end
