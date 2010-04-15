class CreateClusterTypes < ActiveRecord::Migration
  def self.up
    create_table :cluster_types do |t|
      t.column :name, :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :cluster_types
  end
end
