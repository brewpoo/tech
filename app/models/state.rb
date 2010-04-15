class State < ActiveRecord::Base

  has_many :addresses

  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :abbr
  validates_uniqueness_of :abbr
end
