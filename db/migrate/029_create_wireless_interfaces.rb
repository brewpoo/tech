class CreateWirelessInterfaces < ActiveRecord::Migration
  def self.up
    create_table :wireless_interfaces do |t|
      t.column :contact_id, :integer
      t.column :interface_id, :integer
      t.column :is_enabled, :boolean
      t.column :created_on, :datetime
      t.column :updated_on, :datetime
    end
  end

  def self.down
    drop_table :wireless_interfaces
  end
end
