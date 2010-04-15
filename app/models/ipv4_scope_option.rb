class Ipv4ScopeOption < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name

end
