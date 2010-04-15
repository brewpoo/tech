class AddFieldsForAttachements < ActiveRecord::Migration
  def self.up
    add_column :attachments, :content_type, :string
    add_column :attachments, :data, :binary
    add_column :attachments, :created_at, :datetime
    add_column :attachments, :updated_at, :datetime
    add_column :attachments, :description, :string
  end

  def self.down
  end
end
