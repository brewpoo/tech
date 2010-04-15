class Circuit < ActiveRecord::Base
  include TreeFunctions

  acts_as_reportable

  acts_as_tree :order => 'circuit_number'
  belongs_to :connected,
    :class_name => 'Circuit',
    :foreign_key => 'next_id'
  belongs_to :provider,
    :class_name => 'Company',
    :foreign_key => 'provider_id',
    :conditions => 'is_provider=1'
  belongs_to :circuit_type
  belongs_to :line_speed
  belongs_to :line_type
  has_and_belongs_to_many :locations

  has_one :dial_line, :dependent => :destroy
  has_one :pp_line, :dependent => :destroy
  has_one :mp_line, :dependent => :destroy
  
  #validates_uniqueness_of :circuit_number, :allow_nil => true, :allow_blank => true

  def to_label
    provider = self.provider.name if self.provider
    comment = "(#{self.description.first(20)})" unless self.description.blank?
    "#{provider} #{circuit_number} #{comment}"
  end

end
