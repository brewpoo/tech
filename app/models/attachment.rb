class Attachment < ActiveRecord::Base

  belongs_to :attachable, :polymorphic => true

  validates_presence_of :data
  validates_presence_of :description

  attr_accessor :upload_file

  def to_label
    "#{filename} (#{description})"
  end

  def upload_file=(incoming_file)
    self.filename = incoming_file.original_filename
    self.content_type = incoming_file.content_type
    #self.description = incoming_file.description
    self.data = incoming_file.read
  end

  def filename=(new_filename)
    write_attribute("filename", sanitize_filename(new_filename))
  end

  def size
    data.length/1024
  end

  private
  def sanitize_filename(filename)
    #take only the filename not the filespec
    just_filename = File.basename(filename)
    #replace non-alphanumeric, underscore with underscore
    just_filename.gsub(/[^\w\.\-]/,'_')
  end

end
