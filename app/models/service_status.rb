class ServiceStatus < ActiveRecord::Base
  
  acts_as_reportable

  has_many :application_servers

  def to_label
    "#{name}"
  end

end
