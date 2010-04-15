class FixupProjects < ActiveRecord::Migration
  def self.up
    remove_column :projects, :project_number
    add_column :projects, :project_number, :string
  end

  def self.down
    remove_column :projects, :project_number
    add_column :projects, :project_number, :integer
  end
end
