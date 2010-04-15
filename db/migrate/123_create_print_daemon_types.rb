class CreatePrintDaemonTypes < ActiveRecord::Migration
  def self.up
    create_table :print_daemon_types do |t|
      t.column :name, :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :print_daemon_types
  end
end
