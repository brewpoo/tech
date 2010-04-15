class CreatePrinters < ActiveRecord::Migration
  def self.up
    create_table :printers do |t|
      t.column :device_id, :integer
      t.column :netware_queue, :string
      t.column :rsms_queue, :string
      t.column :mainfraime_queue, :string
      t.column :is_ndps, :boolean
    end
  end

  def self.down
    drop_table :printers
  end
end
