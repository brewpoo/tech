class CreateWorkstations < ActiveRecord::Migration
  def self.up
    create_table :workstations do |t|
      t.column :device_id, :integer
      t.column :contact_id, :integer
      t.column :description, :text
    end
  end

  def self.down
    drop_table :workstations
  end
end
