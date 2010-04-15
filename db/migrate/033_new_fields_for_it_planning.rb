class NewFieldsForItPlanning < ActiveRecord::Migration
  def self.up
    add_column :orders, :service_request, :string
    add_column :orders, :management_center, :string
    change_column :orders, :assignee, :text
    add_column :requisitions, :is_pcard_purchase, :boolean
  end

  def self.down
    remove_column :orders, :service_request
    remove_column :orders, :management_center
    change_column :orders, :assignee, :string
    remove_column :requisitions, :is_pcard_purchase
  end
end
