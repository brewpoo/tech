class AddExpiryToWirelessInterfaces < ActiveRecord::Migration
  def self.up
    add_column :wireless_interfaces, :expires_on, :date
  end

  def self.down
    remove_column :wireless_interfaces, :expires_on
  end
end
