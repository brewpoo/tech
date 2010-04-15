class AddHardwareAddressToWirelessInterface < ActiveRecord::Migration
  def self.up
    add_column :wireless_interfaces, :hardware_address, :string
  end

  def self.down
    remove_column :wireless_interfaces, :hardware_address
  end
end
