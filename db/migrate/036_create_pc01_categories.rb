class CreatePc01Categories < ActiveRecord::Migration
  def self.up
    create_table :pc01_categories do |t|
      t.column :title, :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :pc01_categories
  end
end
