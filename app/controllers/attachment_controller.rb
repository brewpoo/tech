class AttachmentController < ApplicationController

  active_scaffold :attachment do |config|
    columns.add :upload_file, :size
    create.link.page = true
    create.multipart = true
    update.link.page = true
    update.multipart = true
    columns[:filename].label = "Attachment"
    list.columns = [:description, :filename, :size, :content_type, :updated_at]
    update.columns = create.columns = [:description, :upload_file]
    actions.exclude :show
    action_links.add('download', :label => 'Download', :type => :record, :crud_type => :create, :inline => false)

  end

  def download
    @attachment = Attachment.find(params[:id])
    send_data @attachment.data, :filename => @attachment.filename, :type => @attachment.content_type
  end

end
