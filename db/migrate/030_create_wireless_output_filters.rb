class CreateWirelessOutputFilters < ActiveRecord::Migration
  def self.up
    create_table :wireless_output_filters do |t|
    t.column "title",         :text
    t.column "description",   :text
    t.column "is_active",     :boolean
    t.column "created_on",    :datetime
    t.column "updated_on",    :datetime
    t.column "output_filter", :text
    end
  end

  def self.down
    drop_table :wireless_output_filters
  end
end
