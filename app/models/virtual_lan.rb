class VirtualLan < ActiveRecord::Base

  has_many :subnets

  validates_presence_of :vlanid
  validates_presence_of :name

  validates_numericality_of :vlanid, :greater_than => 0, :less_than => 4096
  validates_uniqueness_of :vlanid

  def to_label
    "#{name} (#{vlanid})"
  end
    
end
