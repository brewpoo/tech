class CreateIpv4AddressHolds < ActiveRecord::Migration
  def self.up
    create_table :ipv4_address_holds do |t|
      t.column :ipv4_subnet_id, :integer
      t.column :ip_address_packed, :integer, :limit => 8
      t.column :held_on, :datetime
    end
  end

  def self.down
    drop_table :ipv4_address_holds
  end
end
