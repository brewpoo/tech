class Ipv4Scope < ActiveRecord::Base

  belongs_to :ipv4_subnet
  belongs_to :server, :class_name=>'Device', :foreign_key=>'server_id'
  belongs_to :gateway, :class_name=>"Ipv4Interface", :foreign_key=>'gateway_id'
  has_many :ipv4_scope_option_entries
  has_many :ipv4_address_ranges

  validates_uniqueness_of :ipv4_subnet_id, :scope => 'server_id'
end
