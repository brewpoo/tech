class AddFieldsForRevision1 < ActiveRecord::Migration
  def self.up
    add_column :orders, :hwdl, :string
    add_column :orders, :hw, :string
    add_column :requisitions, :due_by, :datetime
    add_column :companies, :bpo, :string
  end

  def self.down
    remove_column :orders, :hwdl
    remove_column :orders, :hw
    remove_column :requisitions, :due_by
    remove_column :companies, :bpo
  end
end
