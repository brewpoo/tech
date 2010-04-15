class Ipv4ScopeOptionEntry < ActiveRecord::Base

  belongs_to :ipv4_scope
  belongs_to :ipv4_scope_option

  validates_presence_of :value

  def to_label
    "#{ipv4_scope_option.name} (#{value})"
  end

end
