class RemoveIdFromDomainsServers < ActiveRecord::Migration
  def self.up
    remove_column :domains_servers, :id
  end

  def self.down
  end
end
