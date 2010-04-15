class PrepForProjectTracker < ActiveRecord::Migration
  def self.up
    rename_column :projects, :body, :comments
    add_column :projects, :engineer_id, :integer
    add_column :projects, :project_type_id, :integer
    add_column :projects, :project_status_id, :integer
    add_column :projects, :priority_id, :integer
    add_column :projects, :requested_on, :date
  end

  def self.down
    rename_column :projects, :comments, :body
    remove_column :projects, :engineer_id
    remove_column :projects, :project_type_id
    remove_column :projects, :project_status_id
    remove_column :projects, :priority_id
    remove_column :projects, :requested_on
  end
end
