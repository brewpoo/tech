class PpLine < ActiveRecord::Base

  acts_as_reportable

  belongs_to :circuit
  belongs_to :subnet
  
  before_validation :set_map_reference
  before_save :update_circuit_type
  
  validates_presence_of :map_reference
  validates_numericality_of :map_reference, :greater_than => 0, :allow_nil => true

  validates_presence_of :circuit

  has_many :notes, :as => :notable, :dependent => :destroy

  def to_label
    "WAN #{map_reference}"
  end

  def PpLine.next_map_reference
    if PpLine.count > 0
      return PpLine.maximum('map_reference')+1
    else
      return 1
    end
  end

  def set_map_reference
    self.map_reference = PpLine.next_map_reference unless !map_reference.blank?
  end

  def location_a
    return nil if circuit.locations.empty?
    circuit.locations.first.long_name
  end

  def location_b
    return nil if circuit.locations.empty?
    circuit.locations.last.long_name
  end

  private

  def update_circuit_type
    self.circuit.update_attribute(:circuit_type,CircuitType.find_by_flag('p2p'))
  end

end
