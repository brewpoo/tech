class AddFieldsForServerRelatedTracking < ActiveRecord::Migration
  def self.up
    add_column :equipment, :warranty_expiry, :date
    add_column :locations, :is_data_center, :boolean
    add_column :devices, :is_hosted, :boolean
    add_column :devices, :is_host, :boolean
    add_column :products, :power_consumption, :integer
    add_column :products, :heat_output, :integer
  end

  def self.down
  end
end
