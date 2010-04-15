class CreatePpLines < ActiveRecord::Migration
  def self.up
    create_table :pp_lines do |t|
      t.column :circuit_id, :integer
      t.column :subnet_id, :integer
      t.column :map_reference, :integer
    end
  end

  def self.down
    drop_table :pp_lines
  end
end
