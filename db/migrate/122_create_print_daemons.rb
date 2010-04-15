class CreatePrintDaemons < ActiveRecord::Migration
  def self.up
    create_table :print_daemons do |t|
      t.column :print_daemon_type_id, :integer
      t.column :server_id, :integer
      t.column :printer_id, :integer
      t.column :name, :string
    end
  end

  def self.down
    drop_table :print_daemons
  end
end
