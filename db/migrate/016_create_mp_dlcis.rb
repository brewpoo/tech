class CreateMpDlcis < ActiveRecord::Migration
  def self.up
    create_table :mp_dlcis do |t|
      t.column :dlci, :integer
      t.column :mp_line_id, :integer
      t.column :interface_id, :integer
    end
  end

  def self.down
    drop_table :mp_dlcis
  end
end
