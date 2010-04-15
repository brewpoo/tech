class AddBudgetCode < ActiveRecord::Migration
  def self.up
    add_column :contacts, :budget_code, :integer
    add_column :orders, :budget_code, :integer
  end

  def self.down
  end
end
