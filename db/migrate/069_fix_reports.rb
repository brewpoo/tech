class FixReports < ActiveRecord::Migration
  def self.up
    rename_column :reports, :controller, :model
    add_column :reports, :controller, :string
  end

  def self.down
  end
end
