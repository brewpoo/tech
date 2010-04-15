class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.column :linkable_id, :integer
      t.column :linkable_type, :string
      t.column :link_category_id, :integer
      t.column :url, :string
      t.column :title, :string
    end
  end

  def self.down
    drop_table :links
  end
end
