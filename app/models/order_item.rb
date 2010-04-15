class OrderItem < ActiveRecord::Base

  acts_as_reportable

  belongs_to :order
  belongs_to :product, :include => :product_family

  has_many :requisition_items, :dependent => :destroy
  has_many :distributed_items, :dependent => :destroy

  validates_presence_of :quantity
  validates_numericality_of :quantity, :greater_than => 0, :only_integer => true
  validates_numericality_of :unit_price, :allow_nil => true
  
  def self.validate_products
    OrderItem.find(:all).each { |o|
    next unless o.product.nil?
    puts "Nil Product for: id:#{o.id} product_id:#{o.product_id}"
    }
    return "Done"
  end

  def substitutable?
    can_substitute
  end

  def manufacturer
    product.product_family.manufacturer.name if product and product.product_family
  end

  def manufacturer=(this)
  end

  def product_family
    product.product_family.name if product and product.product_family
  end
    
  def product_family=(this)
    product.product_family=ProductFamily.find(this) 
  end

  attr_accessor :should_destroy

  def should_destroy?
    should_destroy.to_i == 1
  end

  def to_label
    "#{line_item} #{item_status}"
  end

  def line_item
    "#{quantity} x #{description} @ #{unit_price.to_f.to_currency} each #{line_price.to_f.to_currency} extended"
  end

  def item_details
    "#{description} #{item_status}"
  end

  def item_status
    "(O:#{quantity}/R:#{quantity_requisitioned}/P:#{quantity_purchased}/A:#{quantity_received}/D:#{quantity_distributed})"
  end

  def product_part_number
    return nil if product.part_number.blank?
    "[#{product.part_number}]"
  end

  def order_item_details
    return nil if details.blank?
    "(#{details})"
  end

  def description
    "#{product.full_name} #{product.part} #{order_item_details}" 
  end

  def short
    "#{product.full_name} [#{product.part_number}]"
  end

  def line_price
    return (unit_price * quantity).to_f if unit_price > 0
    return 0
  end

  def number_remaining
    return quantity - quantity_requisitioned
  end

  def number_receivable
    return quantity_purchased - quantity_received
  end

  def number_distributable
    return quantity_received - quantity_distributed
  end

  def quantity_requisitioned
    return 0 unless requisition_items
    count = 0
    requisition_items.each do |item|
      count += item.quantity
    end
    return count
  end

  def quantity_purchased
    return 0 unless requisition_items
    count = 0
    requisition_items.each do |item|
      count += item.quantity if item.requisition.requisition_status.value >= Requisition::PURCHASED
    end
    return count
  end

  def quantity_received
    return 0 unless requisition_items
    count = 0
    requisition_items.each do |req|
      req.received_items.each do |item|
        count += item.quantity
      end
    end
    return count
  end

  def quantity_distributed
    return 0 unless distributed_items
    count = 0
    distributed_items.each do |item|
      count += item.quantity
    end
    return count
  end

  def OrderItem.find_available_for_distribution
    items=Requisition.find(:all,:conditions=>['requisition_status_id=?',RequisitionStatus.find_by_value(Requisition::SHIPPING).id]).collect { |r|
      r.requisition_items.collect{|i| i.order_item}}.flatten
    return items.reject {|item| item.quantity_distributed==item.quanity_received}
  end

  def set_received
    requisition_items.each do |item|
      item.requisition.requisition_status = RequisitionStatus.find_by_value(Requisition::SHIPPING) unless item.requisition.requisition_status.value == Requisition::SHIPPING
    end
  end

end
