class AddPingCounts < ActiveRecord::Migration
  def self.up
    add_column :ipv4_interfaces, :ping_count, :integer
    add_column :ipv4_interfaces, :last_pinged_on, :datetime
  end

  def self.down
  end
end
