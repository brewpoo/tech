class Equipment < ActiveRecord::Base
  acts_as_tree 
  acts_as_reportable

  belongs_to :product
  belongs_to :location
  belongs_to :equipment_status
  belongs_to :role
  has_one :device
  has_many :equipment_properties
  
  validates_uniqueness_of :serial_number, :scope => "product_id", :if => Proc.new { |item| item.product and item.product.detailed }
  validates_numericality_of :count, :greater_than => 0
  validates_date :delivery_date, :allow_nil => true
  validate :serial_number_check

  before_validation :set_count

  attr_accessor :product_family, :manufacturer, :check_out_quantity


  def serial_number_check
    errors.add_to_base('Must supply serial number for detailed products') if product and product.detailed and serial_number.blank?
  end
    
  def product_full_name
    if product
      product.full_name
    end
  end

  def to_label
    if self.product
      "#{self.product.product_family.name} #{self.product.name} (SN: #{serial_number})"
    elsif !self.serial_number.blank?
      "SN: #{serial_number} - Add Product Info"
    else
      "Add Equipment Details"
    end
  end

  def set_count
    self.count = 1 if self.product and self.product.detailed
    self.count = 1 if self.count.blank?
  end

  def Equipment.find_stock_items
    @@stock_items=Equipment.find(:all,:conditions=>['equipment_status_id=?',EquipmentStatus.find_by_flag('stock')])
    return @@stock_items
  end

end
