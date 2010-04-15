class AddMpLineSupport < ActiveRecord::Migration
  def self.up
    add_column :mp_lines, :old_mp_line_id, :integer
    add_column :mp_dlcis, :old_dlci_id, :integer
    add_column :mp_pvcs, :old_pvc_id, :integer
  end

  def self.down
  end
end
