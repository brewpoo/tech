class ChangeProjectNumberToInteger < ActiveRecord::Migration
  def self.up
    add_column :projects, :old_project_number, :string
    Project.reset_column_information
    Project.find(:all).each do |p|
      p.update_attribute(:old_project_number, p.project_number)
    end
    change_column :projects, :project_number, :integer 
  end

  def self.down
  end
end
