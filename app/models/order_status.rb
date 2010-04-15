class OrderStatus < CachedModel

  acts_as_reportable

  has_many :orders

  def to_label
    name
  end

end
