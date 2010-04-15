class FixPc01CategoriesOrderType < ActiveRecord::Migration
  def self.up
    rename_column :pc01_categories, :order_type, :order_type_id
  end

  def self.down
  end
end
