class AddCompanyToDepartment < ActiveRecord::Migration
  def self.up
    add_column :departments, :company_id, :integer
  end

  def self.down
    remove_column :departments, :company_id
  end
end
