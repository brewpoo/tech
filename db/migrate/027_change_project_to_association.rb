class ChangeProjectToAssociation < ActiveRecord::Migration
  def self.up
    rename_column :orders, :project, :old_project
    add_column :orders, :project_id, :integer
  end

  def self.down
    remove_column :orders, :project_id
    rename_column :orders, :old_project, :project
  end
end
