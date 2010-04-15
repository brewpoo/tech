class RequisitionItem < ActiveRecord::Base

  acts_as_reportable

  belongs_to :requisition
  belongs_to :order_item#, :include => :product
  #has_one :product, :through => :order_item
  has_many :received_items, :dependent => :destroy

  validates_presence_of :quantity
  validates_numericality_of :quantity, :greater_than => 0, :integer_only => true

  attr_accessor :receive_quantity, :distribute_quantity

  attr_accessor :should_destroy

  before_destroy :unprocess_order

  def should_destroy?
    should_destroy.to_i == 1
  end


  def to_label
    "#{quantity} x #{description} @ #{unit_price.to_f.to_currency}"
  end

  def requisition_item_details
    return nil if details.blank?
    "[#{details}]"
  end

  def description
    "#{order_item.description} #{requisition_item_details}"
  end

  def line_price
    return (unit_price * quantity).to_f if unit_price and unit_price > 0
    return 0
  end

  def can_substitute
    order_item.can_substitute
  end

  def number_receivable
    return quantity_purchased - quantity_received
  end
  
  def receivable?
    number_receivable>0 ? true : false
  end

  def number_distributable
    return quantity_received - quantity_distributed
  end

  def distributable?
    number_distributable>0 ? true : false
  end

  def quantity_purchased
    return quantity
  end

  def quantity_received
    return 0 unless received_items
    count = 0
    received_items.each do |item|
      count += item.quantity
    end
    return count
  end

  def quantity_distributed
    return 0 unless order_item.distributed_items
    count = 0
    order_item.distributed_items.each do |item|
      count += item.quantity
    end
    return count
  end

  def RequisitionItem.available_for_receipt
      Requisition.find(:all).select{|req| req.requisition_status.value >= Requisition::PURCHASED and
                                          req.requisition_status.value < Requisition::CLOSED}.collect { |r|
          r.requisition_items
        }.flatten!
  end

  def RequisitionItem.find_available_for_receipt
    available_for_receipt = CACHE.get("available_for_receipt")
    if available_for_receipt == nil
      RequisitionItem.run_precache
      available_for_receipt = CACHE.get("available_for_receipt")
    end
    return available_for_receipt
  rescue
    return RequisitionItem.available_for_receipt
  end

  def RequisitionItem.available_for_distribution
      Requisition.find(:all).select {|req| req.requisition_status.value >= Requisition::SHIPPING}.collect { |r|
          r.requisition_items
        }.flatten!
  end

  def RequisitionItem.find_available_for_distribution
    available_for_distribution = CACHE.get("available_for_distribution")
    if available_for_distribution == nil
      RequisitionItem.run_precache
      available_for_distribution = CACHE.get("available_for_distribution")
    end
    return available_for_distribution
  rescue
    return RequisitionItem.available_for_distribution
  end

  def RequisitionItem.run_precache
    CACHE.set("available_for_receipt",RequisitionItem.available_for_receipt)
    CACHE.set("available_for_distribution",available_for_distribution)
  end

  def unprocess_order
    order_item.order.update_attribute(:order_status,OrderStatus.find_by_value(Order::APPROVED))
  end

end
