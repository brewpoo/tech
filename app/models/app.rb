class App < ActiveRecord::Base

  acts_as_reportable

  belongs_to :department
  belongs_to :owner, :class_name => "Contact", :foreign_key => 'owner_id'
  belongs_to :manager, :class_name => "Contact", :foreign_key => 'manager_id'
  belongs_to :priority

  has_many :application_servers, :foreign_key => 'application_id'
  has_many :servers, :through => :application_servers

  def to_label
    short_name.blank? ? name : short_name
  end

end
