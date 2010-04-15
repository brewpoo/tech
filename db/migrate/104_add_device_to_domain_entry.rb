class AddDeviceToDomainEntry < ActiveRecord::Migration
  def self.up
    add_column :domain_entries, :device_id, :integer
  end

  def self.down
    remove_column :domain_entries, :device_id
  end
end
