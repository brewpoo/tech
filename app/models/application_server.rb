class ApplicationServer < ActiveRecord::Base

  acts_as_reportable

  belongs_to :application, :class_name => "App", :foreign_key => "application_id"
  belongs_to :server
  belongs_to :service
  belongs_to :service_status

  validates_presence_of :application
  validates_presence_of :server
  validates_presence_of :service
  validates_presence_of :service_status

  def to_label
    "#{server.hostname} (#{service.name}/#{service_status.name})"
  end

end
