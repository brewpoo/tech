class PrintDaemonType < ActiveRecord::Base

  has_many :print_daemons

  validates_uniqueness_of :name

end
