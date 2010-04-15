class CreateDomainNames < ActiveRecord::Migration
  def self.up
    create_table :domain_names do |t|
      t.column :nameable_id, :integer
      t.column :nameable_type, :string
      t.column :hostname, :string 
      t.column :domain_id, :integer
      t.column :publish_reverse, :boolean
      t.column :created_on, :date
      t.column :updated_on, :date
    end
  end

  def self.down
    drop_table :domain_names
  end
end
