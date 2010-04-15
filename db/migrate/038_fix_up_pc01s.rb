class FixUpPc01s < ActiveRecord::Migration
  def self.up
    change_column :pc01s, :pc01_number, :integer
    add_column :pc01_categories, :order_type, :integer
  end

  def self.down
    change_column :pc01s, :pc01_number, :string
    remove_column :pc01_categories, :order_type
  end
end
