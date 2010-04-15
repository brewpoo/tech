class AddProjectColumns < ActiveRecord::Migration
  def self.up
    add_column :projects, :project_status, :integer
    add_column :projects, :manager_id, :integer
    add_column :projects, :department_id, :integer
    add_column :projects, :requestor_id, :integer
    add_column :projects, :priority, :integer
    add_column :projects, :started_on, :date
    add_column :projects, :completed_on, :date
    add_column :projects, :estimated_completion, :string
  end

  def self.down
    remove_column :projects, :project_status
    remove_column :projects, :manager_id
    remove_column :projects, :department_id
    remove_column :projects, :requestor_id
    remove_column :projects, :priority
    remove_column :projects, :started_on
    remove_column :projects, :completed_on
    remove_column :projects, :estimated_completion
  end
end
