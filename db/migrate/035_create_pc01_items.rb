class CreatePc01Items < ActiveRecord::Migration
  def self.up
    create_table :pc01_items do |t|
      t.column :pc01_id, :integer
      t.column :pc01_category_id, :integer
      t.column :pc01_disposition_id, :integer
      t.column :description, :text
      t.column :is_stock_item, :boolean
      t.column :is_fullfilled, :boolean
      t.column :is_replenished, :boolean
    end
  end

  def self.down
    drop_table :pc01_items
  end
end
