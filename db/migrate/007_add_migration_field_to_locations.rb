class AddMigrationFieldToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :old_id, :integer
  end

  def self.down
    remove_column :locations, :old_id
  end
end
