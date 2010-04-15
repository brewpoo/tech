class RenameOperationSystemFullName < ActiveRecord::Migration
  def self.up
    rename_column :operating_systems, :full_name, :long_name
  end

  def self.down
  end
end
