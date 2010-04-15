class AddDeliverByAndReleaseNumber < ActiveRecord::Migration
  def self.up
    add_column :requisitions, :deliver_by, :date
    add_column :requisitions, :release_number, :string
  end

  def self.down
    remove_column :requisitions, :deliver_by
    remove_column :requisitions, :release_number
  end
end
