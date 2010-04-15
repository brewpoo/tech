class AddCompletionToPc01 < ActiveRecord::Migration
  def self.up
    add_column :pc01s, :is_completed, :boolean
    add_column :orders, :pc01_id, :integer
  end

  def self.down
  end
end
