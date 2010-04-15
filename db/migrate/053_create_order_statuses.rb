class CreateOrderStatuses < ActiveRecord::Migration
  def self.up
    create_table :order_statuses do |t|
      t.column :name, :string
      t.column :value, :integer
    end
    OrderStatus.create(:name => 'Draft', :value => Order::DRAFT)
    OrderStatus.create(:name => 'Opened', :value => Order::OPENED)
    OrderStatus.create(:name => 'Approved', :value => Order::APPROVED)
    OrderStatus.create(:name => 'Processed', :value => Order::PROCESSED)
    OrderStatus.create(:name => 'Closed', :value => Order::CLOSED)
    rename_column :orders, :order_status, :order_status_old
    add_column :orders, :order_status_id, :integer
    Order.reset_column_information
    Order.find_all.each do |order|
      order.update_attribute :order_status, OrderStatus.find_by_value(order.order_status_old)
    end
  end

  def self.down
    drop_table :order_statuses
    rename_column :orders, :order_status_old, :order_status
    remove_column :orders, :order_status_id
  end
end
