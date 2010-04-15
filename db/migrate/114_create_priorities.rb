class CreatePriorities < ActiveRecord::Migration
  def self.up
    create_table :priorities do |t|
      t.column :name, :string
      t.column :value, :integer
    end
  end

  def self.down
    drop_table :priorities
  end
end
