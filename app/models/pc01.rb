class Pc01 < ActiveRecord::Base

  acts_as_reportable

  has_many :pc01_items, :dependent => :destroy
  belongs_to :location
  belongs_to :department
  belongs_to :approved_by, :class_name => 'Contact',
    :foreign_key => 'approved_by'
  belongs_to :submitted_by, :class_name => 'Contact',
    :foreign_key => 'submitted_by'
  has_many :notes, :as => :notable
  has_many :orders

  validates_presence_of :pc01_number
  validates_uniqueness_of :pc01_number

  validates_presence_of :management_center
  validates_presence_of :department
  validates_presence_of :submitted_by

  validates_numericality_of :budget_year, :greater_than => 1980, :only_integer => true, :allow_nil => true
  validates_numericality_of :fund_code, :greater_than => 0, :only_integer => true, :allow_nil => true
  validates_numericality_of :budget_code, :greater_than => 1000, :only_integer => true, :allow_nil => true

  before_validation_on_create :set_pc01_number

  def display_action?(action)
    return true if self.new_record?
    case action
      when 'order'
        return false unless self.has_items_to_order?
    end
    return true
  end

  def Pc01.next_pc01_number
    if Pc01.count > 0
      return Pc01.maximum('pc01_number')+1
    else
      return 1
    end
  end

  def set_pc01_number
    self.pc01_number = Pc01.next_pc01_number
  end

  def to_label
    "#{pc01_number}"
  end

  def budget_string
    "#{fund_code}-#{budget_code}-#{management_center}-0000-#{work_order}"
  end

  def outstanding_stock_items
    pc01_items.select{|i| i.is_stock_item and !i.is_replenished}
  end

  def has_items_to_order?
    pc01_items.detect{|i| !i.is_replenished and !i.is_stock_item}
  end

end
