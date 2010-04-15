class PrintDaemon < ActiveRecord::Base

  belongs_to :print_daemon_type
  belongs_to :server
  belongs_to :printer

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => 'server_id'

end
