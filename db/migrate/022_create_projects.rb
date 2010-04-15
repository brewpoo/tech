class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.column :project_number, :integer
      t.column :title, :string
      t.column :description, :text
      t.column :body, :text
      t.column :created_by, :string
      t.column :created_on, :datetime
      t.column :updated_on, :datetime
    end
  end

  def self.down
    drop_table :projects
  end
end
