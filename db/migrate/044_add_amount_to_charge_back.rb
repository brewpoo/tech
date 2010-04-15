class AddAmountToChargeBack < ActiveRecord::Migration
  def self.up
    add_column :pc01_items, :charge_back_amount, :decimal, :precision => 10, :scale => 2
  end

  def self.down
    remove_column :pc01_items, :charge_back_amount
  end
end
