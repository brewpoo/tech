class PhoneType < ActiveRecord::Base

  has_many :phones
  
  validates_presence_of :phone_type
  validates_uniqueness_of :phone_type

  def to_label
    "#{phone_type}"
  end

end
