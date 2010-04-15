class AddManagerToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :manager_id, :integer
  end

  def self.down
    remove_column :orders, :manager_id
  end
end
