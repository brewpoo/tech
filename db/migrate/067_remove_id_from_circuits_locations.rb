class RemoveIdFromCircuitsLocations < ActiveRecord::Migration
  def self.up
    remove_column :circuits_locations, :id
  end

  def self.down
  end
end
