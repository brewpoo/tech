class MpLine < ActiveRecord::Base

  acts_as_reportable

  belongs_to :device
  belongs_to :circuit

  before_save :update_circuit_type

  validates_presence_of :device
  validates_presence_of :circuit

  def to_label
    "#{device.hostname if device} #{circuit.to_label}"
  end

  private

  def update_circuit_type
    self.circuit.update_attribute(:circuit_type,CircuitType.find_by_flag('mp'))
  end

end
