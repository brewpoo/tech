class AddDomainPrimaryServer < ActiveRecord::Migration
  def self.up
    add_column :domains, :primary_server_id, :integer
  end

  def self.down
  end
end
