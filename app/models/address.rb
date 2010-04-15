class Address < ActiveRecord::Base

  belongs_to :location
  belongs_to :state

  validates_presence_of :street_address
  validates_presence_of :city

  def to_label
    "#{self.street_address}, #{self.city}, #{self.state.abbr} #{self.zip}"
  end

end
