class FixUpPc01Items < ActiveRecord::Migration
  def self.up
    add_column :pc01_items, :quantity, :integer
    add_column :pc01_items, :is_charge_back, :boolean
    remove_column :pc01_items, :pc01_disposition_id
    drop_table :pc01_dispositions
    add_column :pc01s, :created_on, :datetime
    add_column :pc01s, :department_id, :integer
    remove_column :pc01s, :assignee_id
    add_column :pc01s, :assigned_users, :text
  end

  def self.down
  end
end
