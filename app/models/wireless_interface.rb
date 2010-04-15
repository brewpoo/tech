class WirelessInterface < ActiveRecord::Base

  acts_as_reportable

  belongs_to :contact
  belongs_to :interface, :conditions => 'is_wireless=1'

  validates_presence_of :contact
#  validates_presence_of :interface

  validates_format_of :hardware_address, :with => /[0-9a-f]{12}/
  validates_uniqueness_of :hardware_address


  def self.expire
    WirelessInterface.find(:all).each do |i|
      next if i.expires_on.blank? or i.expires_on.nil?
      i.update_attribute(:is_enabled,false) if i.expires_on < Date.today
    end
  end

  def self.fix_up_interfaces
    WirelessInterface.find(:all).each do |w|
      w.update_attribute(:hardware_address,w.interface.hardware_address) if w.interface
      w.interface.destroy if w.interface
    end
  end

end
