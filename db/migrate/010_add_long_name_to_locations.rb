class AddLongNameToLocations < ActiveRecord::Migration
  def self.up
    add_column :locations, :long_name, :string
    Location.reset_column_information
    Location.find(:all).each do |location|
      location.update_attribute :long_name, location.full_name(" ")
    end
  end

  def self.down
    remove_column :locations, :long_name
  end
end
