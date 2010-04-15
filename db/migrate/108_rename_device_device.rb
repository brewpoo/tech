class RenameDeviceDevice < ActiveRecord::Migration

  def self.up
    rename_column :devices, :host_id, :device_id
  end

  def self.down
  end
end
