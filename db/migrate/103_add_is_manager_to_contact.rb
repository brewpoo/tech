class AddIsManagerToContact < ActiveRecord::Migration
  def self.up
    add_column :contacts, :is_manager, :boolean
  end

  def self.down
    remove_column :contacts, :is_manager
  end
end
