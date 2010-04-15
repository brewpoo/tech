class Phone < ActiveRecord::Base

  acts_as_reportable

  belongs_to :phone_type
  belongs_to :phonable, :polymorphic => true

  validates_presence_of :number
#  validates_format_of :number, :with => /^((\+\d{1,3}(-| )?\(?\d\)?(-| )?\d{1,5})|(\(?\d{2,6}\)?))(-| )?(\d{3,4})(-| )?(\d{4})(( x| ext)\d{1,5}){0,1}$/
#  validates_uniqueness_of :number
  validates_associated :phone_type
  validates_presence_of :phone_type

  def to_label
    label = ""
    label = " (#{description})" if description?
    "#{phone_type.phone_type} #{number}" + label
  end

end
