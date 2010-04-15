class CreateLineTypes < ActiveRecord::Migration
  def self.up
    create_table :line_types do |t|
      t.column :name, :string
      t.column :description, :text
    end
    add_column :circuits, :line_type_id, :integer
  end

  def self.down
    drop_table :line_types
    remove_column :circuits, :line_type_id
  end
end
