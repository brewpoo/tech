class AddStorageLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :is_storage_location, :boolean
  end

  def self.down
    remove_column :locations, :is_storage_location
  end
end
