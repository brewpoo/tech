class FixUpHosts < ActiveRecord::Migration
  def self.up
    remove_column :devices, :is_hosted
    remove_column :devices, :is_host
    remove_column :devices, :old_host_id
    add_column :devices, :host_id, :integer
  end

  def self.down
  end
end
