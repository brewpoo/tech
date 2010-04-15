class AddTreeToLineTypes < ActiveRecord::Migration
  def self.up
    add_column :line_types, :parent_id, :integer
    add_column :line_types, :old_channel_id, :integer
  end

  def self.down
  end
end
