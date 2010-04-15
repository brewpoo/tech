module AttachmentHelper

  def upload_file_form_column(record, input_name)
    file_field :record, :upload_file, :name => input_name
  end

  def size_column(record)
    "#{record.size} KiB"
  end

end
