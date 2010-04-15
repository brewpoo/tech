class AddBudgetFieldsToPc01 < ActiveRecord::Migration
  def self.up
    add_column :pc01s, :budget_year, :integer
    add_column :pc01s, :fund_code, :integer
    add_column :pc01s, :work_order, :string
    add_column :pc01s, :budget_code, :integer
  end

  def self.down
  end
end
