class MoveReceivedItemUnderRequisitionItem < ActiveRecord::Migration
  def self.up
    rename_column :received_items, :order_item_id, :requisition_item_id
  end

  def self.down
    rename_column :received_items, :requisition_item_id, :order_item_id
  end
end
