class AddReplenishToPc01Items < ActiveRecord::Migration
  def self.up
    add_column :pc01_items, :replenished_on, :date
  end

  def self.down
    remove_column :pc01_items, :replenished_on
  end
end
