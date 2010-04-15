class CreateOperatingSystems < ActiveRecord::Migration
  def self.up
    create_table :operating_systems do |t|
      t.column :parent_id, :integer
      t.column :name, :string
      t.column :full_name, :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :operating_systems
  end
end
