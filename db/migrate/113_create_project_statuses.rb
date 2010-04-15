class CreateProjectStatuses < ActiveRecord::Migration
  def self.up
    create_table :project_statuses do |t|
      t.column :name, :string
      t.column :value, :integer
    end
  end

  def self.down
    drop_table :project_statuses
  end
end
