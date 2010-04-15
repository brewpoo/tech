class AddBudgetFieldsToManager < ActiveRecord::Migration
  def self.up
    add_column :contacts, :fund_code, :integer
    add_column :contacts, :management_center, :integer
    add_column :contacts, :work_order, :string
  end

  def self.down
  end
end
