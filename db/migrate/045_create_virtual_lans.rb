class CreateVirtualLans < ActiveRecord::Migration
  def self.up
    create_table :virtual_lans do |t|
      t.column :subnet_id, :integer
      t.column :vlanid, :integer
      t.column :name, :string
      t.column :description, :text
      t.column :is_private, :boolean
    end
  end

  def self.down
    drop_table :virtual_lans
  end
end
