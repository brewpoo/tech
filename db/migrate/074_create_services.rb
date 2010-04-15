class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.column :name, :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :services
  end
end
