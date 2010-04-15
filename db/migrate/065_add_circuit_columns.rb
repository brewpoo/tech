class AddCircuitColumns < ActiveRecord::Migration
  def self.up
    add_column :line_speeds, :old_linespeed_id, :integer
    add_column :circuits, :old_circuit_id, :integer
  end

  def self.down
  end
end
