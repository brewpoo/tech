class AddTimestamps < ActiveRecord::Migration
  def self.up
    add_column :ipv4_interfaces, :created_on, :datetime
    add_column :ipv4_interfaces, :updated_on, :datetime
  end

  def self.down
  end
end
