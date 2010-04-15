class ConvertOrderTypes < ActiveRecord::Migration
  def self.up
    ActiveRecord::Base.transaction do
      say "Creating new column"
      add_column :orders, :order_type_id, :integer
      say "Renaming old column"
      rename_column :orders, :order_type, :order_type_old
      Order.reset_column_information
      say "Setting new column to equivalent from old column"
      Order.find(:all).each do |order|
        order.update_attribute :order_type, OrderType.find_by_name(order.order_type_old)
      end    
      say "Removing old column"
      #remove_column :orders, :order_type_old
    end
  end

  def self.down
    ActiveRecord::Base.transaction do
      add_column :orders, :order_type, :string
      rename_column :orders, :order_type_id, :order_type_old_id
      Order.reset_column_information
      Order.find(:all).each do |order|
        order.update_attribute :order_type, OrderType.find(order.order_type_old_id)
      end
      #remove_column :orders, :order_type_old
    end
  end
  
end
