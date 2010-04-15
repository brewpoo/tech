class AddDetailsToRequisitionItems < ActiveRecord::Migration
  def self.up
    add_column :requisition_items, :details, :text
  end

  def self.down
    remove_column :requisition_items, :details
  end
end
