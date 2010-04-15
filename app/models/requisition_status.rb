class RequisitionStatus < CachedModel

  acts_as_reportable

  has_many :requisitions
    
  def to_label
    name
  end

end
