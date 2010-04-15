class VirtualHostType < ActiveRecord::Base

  has_many :ipv4_virtual_hosts

  def to_label
    "#{name}"
  end

end
