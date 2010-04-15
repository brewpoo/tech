class Priority < ActiveRecord::Base

  acts_as_reportable

  has_many :projects

end
