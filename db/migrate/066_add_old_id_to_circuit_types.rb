class AddOldIdToCircuitTypes < ActiveRecord::Migration
  def self.up
    add_column :circuit_types, :old_application_id, :integer
  end

  def self.down
  end
end
