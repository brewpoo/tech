class AddClosedOnToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :closed_on, :date
    #Order.reset_column_information
    #Order.find(:all, :conditions => ['order_status = ? and closed_on IS NULL',Order::CLOSED]).each do |order|
    #  order.update_attribute :closed_on, Time.now
    #end
  end

  def self.down
    remove_column :orders, :closed_on
  end
end
