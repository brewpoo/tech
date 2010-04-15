class RemoveUnusedTables < ActiveRecord::Migration
  def self.up
    drop_table :attributes
    drop_table :product_attributes
    drop_table :equipment_attributes
  end

  def self.down
  end
end
