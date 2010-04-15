class CreateMpLines < ActiveRecord::Migration
  def self.up
    create_table :mp_lines do |t|
      t.column :device_id, :integer
      t.column :circuit_id, :integer
    end
  end

  def self.down
    drop_table :mp_lines
  end
end
