class AddMissingIndexes < ActiveRecord::Migration
  def self.up
    add_index :ipv4_scope_option_entries, :ipv4_scope_id
    add_index :ipv4_scope_option_entries, :ipv4_scope_option_id
    add_index :print_daemons, :server_id
    add_index :print_daemons, :print_daemon_type_id
    add_index :print_daemons, :printer_id
  end
  
  def self.down
    remove_index :ipv4_scope_option_entries, :ipv4_scope_id
    remove_index :ipv4_scope_option_entries, :ipv4_scope_option_id
    remove_index :print_daemons, :server_id
    remove_index :print_daemons, :print_daemon_type_id
    remove_index :print_daemons, :printer_id
  end
end
