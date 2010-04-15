class AddPriorityToApplications < ActiveRecord::Migration
  def self.up
    add_column :apps, :priority_id, :integer
  end

  def self.down
    remove_column :apps, :priority_id
  end
end
