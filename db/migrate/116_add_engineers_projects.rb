class AddEngineersProjects < ActiveRecord::Migration
  def self.up
    create_table "engineers_projects", :id => false, :force => true do |t|
      t.column "engineer_id", :integer
      t.column "project_id", :integer
    end
    add_column :contacts, :is_engineer, :boolean
  end

  def self.down
    drop_table :engineers_projects
    remove_column :contacts, :is_engineer
  end
end
