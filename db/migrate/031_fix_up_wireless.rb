class FixUpWireless < ActiveRecord::Migration
  def self.up
    add_column :interfaces, :is_wireless, :boolean
    add_column :wireless_interfaces, :description, :text
  end

  def self.down
    remove_column :interfaces, :is_wireless
    remove_column :wireless_interfaces, :description
  end
end
