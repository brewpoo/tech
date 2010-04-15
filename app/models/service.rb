class Service < ActiveRecord::Base
  
  acts_as_reportable
  
  has_many :application_servers

  validates_uniqueness_of :name

  def to_label
    "#{name}"
  end

end
