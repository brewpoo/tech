class Pc01Item < ActiveRecord::Base

  acts_as_reportable

  belongs_to :pc01
  belongs_to :pc01_category
  
  validates_presence_of :pc01_category
  validates_associated :pc01_category

  validates_presence_of :quantity
  validates_numericality_of :quantity, :greater_than => 0

  attr_accessor :selected

  def charge_back
    return " -Charge Back- " if is_charge_back?
  end

  def stock_item
    return " -Stock Item- " if is_stock_item?
  end

  def item_description
    return "[#{description}]" unless description.blank?
  end

  def to_label
    "#{quantity} x #{pc01_category.title} #{item_description} #{charge_back} #{stock_item}"
  end

  def pc01_details
    return if pc01.nil?
    "SR: #{pc01.service_request} Dept: #{pc01.department.to_label} MC: #{pc01.budget_string} Users: #{pc01.assigned_users}"
  end

end
