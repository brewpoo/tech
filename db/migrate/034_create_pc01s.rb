class CreatePc01s < ActiveRecord::Migration
  def self.up
    create_table :pc01s do |t|
      t.column :pc01_number, :string
      t.column :pc01_dated, :date
      t.column :received_on, :date
      t.column :approved_on, :date
      t.column :approved_by, :integer
      t.column :service_request, :string
      t.column :submitted_by, :integer
      t.column :assignee_id, :integer
      t.column :location_id, :integer
      t.column :description, :text
      t.column :management_center, :string
    end
  end

  def self.down
    drop_table :pc01s
  end
end
