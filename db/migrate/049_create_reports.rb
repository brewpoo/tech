class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.column :title, :string
      t.column :description, :text
      t.column :controller, :string
    end
  end

  def self.down
    drop_table :reports
  end
end
