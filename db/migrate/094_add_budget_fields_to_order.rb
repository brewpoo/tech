class AddBudgetFieldsToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :budget_year, :integer
    add_column :orders, :fund_code, :integer
    add_column :orders, :work_order, :string
  end

  def self.down
  end
end
