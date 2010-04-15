class CreateProjectTypes < ActiveRecord::Migration
  def self.up
    create_table :project_types do |t|
      t.column :name, :string
      t.column :description, :string
      t.column :abbreviation, :string
    end
  end

  def self.down
    drop_table :project_types
  end
end
