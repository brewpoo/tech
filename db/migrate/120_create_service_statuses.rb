class CreateServiceStatuses < ActiveRecord::Migration
  def self.up
    create_table :service_statuses do |t|
      t.column :name, :string
      t.column :description, :text
      t.column :value, :integer
    end
  end

  def self.down
    drop_table :service_statuses
  end
end
