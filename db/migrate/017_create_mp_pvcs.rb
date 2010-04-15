class CreateMpPvcs < ActiveRecord::Migration
  def self.up
    create_table :mp_pvcs do |t|
      t.column :dlci_a_id, :integer
      t.column :dlci_b_id, :integer
    end
  end

  def self.down
    drop_table :mp_pvcs
  end
end
