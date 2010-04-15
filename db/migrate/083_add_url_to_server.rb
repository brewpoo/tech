class AddUrlToServer < ActiveRecord::Migration
  def self.up
     add_column :servers, :management_url, :string
  end

  def self.down
  end
end
