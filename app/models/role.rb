class Role < ActiveRecord::Base

  has_and_belongs_to_many :users
  has_and_belongs_to_many :tasks
  has_many :equipment

  validates_uniqueness_of :flag, :allow_nil => true
  
  def user_emails
    users.collect{|u| u.contact.email}.uniq
  end

  def self.select_map
    Role.find(:all).map{|r| [r.name, r.id]}
  end

end
