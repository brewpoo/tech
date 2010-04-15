class CreateOrderTypes < ActiveRecord::Migration
  def self.up
    create_table :order_types do |t|
      t.column :name, :string
      t.column :processor_id, :integer
    end
  end

  def self.down
    drop_table :order_types
  end
end
