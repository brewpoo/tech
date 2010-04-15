class CreateApplications < ActiveRecord::Migration
  def self.up
    create_table :applications do |t|
      t.column :name, :string
      t.column :short_name, :string
      t.column :description, :text
      t.column :department_id, :integer
      t.column :manager_id, :integer
      t.column :owner_id, :integer
    end
  end

  def self.down
    drop_table :applications
  end
end
