class AddCommentToRequisition < ActiveRecord::Migration
  def self.up
    add_column :requisitions, :comment, :string
  end

  def self.down
    remove_column :requisitions, :comment
  end
end
