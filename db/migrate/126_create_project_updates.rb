class CreateProjectUpdates < ActiveRecord::Migration
  def self.up
    create_table :project_updates do |t|
      t.column :project_id, :integer
      t.column :created_on, :datetime
      t.column :updated_on, :datetime
      t.column :created_by, :string
      t.column :body, :text
    end
  end

  def self.down
    drop_table :project_updates
  end
end
