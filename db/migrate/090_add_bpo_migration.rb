class AddBpoMigration < ActiveRecord::Migration
  def self.up
    add_column :companies, :bpo_expiry, :date
  end

  def self.down
    remove_column :companies, :bpo_expiry
  end
end
