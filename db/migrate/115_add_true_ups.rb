class AddTrueUps < ActiveRecord::Migration
  def self.up
    add_column :pc01_items, :is_true_up, :boolean
  end

  def self.down
    remove_column :pc01_items, :is_true_up
  end
end
