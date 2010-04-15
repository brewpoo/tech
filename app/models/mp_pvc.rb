class MpPvc < ActiveRecord::Base

  acts_as_reportable

  belongs_to :dlci_a, :class_name => "MpDlci", :foreign_key => "dlci_a_id"
  belongs_to :dlci_b, :class_name => "MpDlci", :foreign_key => "dlci_b_id"

  validates_presence_of :dlci_a
  validates_presence_of :dlci_b

end
