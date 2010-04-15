class AddOwnerToEquipment < ActiveRecord::Migration
  def self.up
    add_column :equipment, :role_id, :integer
  end

  def self.down
    remove_column :equipment, :role_id
  end
end
