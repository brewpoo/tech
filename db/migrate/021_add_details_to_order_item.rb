class AddDetailsToOrderItem < ActiveRecord::Migration
  def self.up
    add_column :order_items, :details, :text
  end

  def self.down
    remove_column :order_items, :details
  end
end
