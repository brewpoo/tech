class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.column :filename, :string
      t.column :attachable_id, :integer
      t.column :attachable_type, :string
    end
  end

  def self.down
    drop_table :attachments
  end
end

