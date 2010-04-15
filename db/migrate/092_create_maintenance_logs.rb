class CreateMaintenanceLogs < ActiveRecord::Migration
  def self.up
    create_table :maintenance_logs do |t|
      t.column :loggable_id, :integer
      t.column :loggable_type, :string
      t.column :created_on, :datetime
      t.column :updated_on, :datetime
      t.column :created_by, :string
      t.column :title, :string
      t.column :body, :text
    end

    add_index :maintenance_logs, :loggable_id
    add_index :maintenance_logs, :loggable_type
    add_index :maintenance_logs, :created_on
  end

  def self.down
    drop_table :maintenance_logs
  end
end
