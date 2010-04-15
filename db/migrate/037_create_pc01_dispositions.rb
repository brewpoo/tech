class CreatePc01Dispositions < ActiveRecord::Migration
  def self.up
    create_table :pc01_dispositions do |t|
      t.column :title, :string
      t.column :description, :text
      t.column :flag, :string
    end
  end

  def self.down
    drop_table :pc01_dispositions
  end
end
