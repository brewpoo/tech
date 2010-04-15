class MpDlci < ActiveRecord::Base

  acts_as_reportable

  belongs_to :mp_line
  belongs_to :interface

  has_one :mp_a_pvc, :class_name => 'MpPvc', :foreign_key => 'dlci_a_id'
  has_one :mp_b_pvc, :class_name => 'MpPvc', :foreign_key => 'dlci_b_id'

  validates_presence_of :mp_line
  validates_presence_of :interface

  validates_uniqueness_of :dlci, :scope => 'mp_line_id'

  def to_label
    "#{interface.device.to_label if interface} #{mp_line.circuit.circuit_number}:#{dlci}"
  end
  
end
