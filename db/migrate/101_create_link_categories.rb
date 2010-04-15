class CreateLinkCategories < ActiveRecord::Migration
  def self.up
    create_table :link_categories do |t|
      t.column :parent_id, :integer
      t.column :name, :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :link_categories
  end
end
