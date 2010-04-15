class ChangeProjectEngineerToLeadEngineer < ActiveRecord::Migration
  def self.up
    rename_column :projects, :engineer_id, :lead_engineer_id
  end

  def self.down
  end
end
