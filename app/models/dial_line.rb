class DialLine < ActiveRecord::Base

  acts_as_reportable

  belongs_to :device
  belongs_to :circuit, :dependent => :destroy

  before_save :update_circuit_type

  has_many :phones, :as => :phonable, :dependent => :destroy

  validates_presence_of :device
  validates_presence_of :circuit

  def to_label
    "#{circuit.to_label if circuit}"
  end

  def numbers
    str = "" 
    phones.each  do |phone|
      str = str + phone.number + " "
    end
    return str
  end

  private

  def update_circuit_type
    self.circuit.update_attribute(:circuit_type,CircuitType.find_by_flag('dl'))
  end

end

