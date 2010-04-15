class ReceivedItem < ActiveRecord::Base

  acts_as_reportable
  
  belongs_to :requisition_item, :include => :requisition
  belongs_to :receiver, 
    :class_name => "User",
    :foreign_key => "receiver_id"
  #has_one :order_item, :through => :requisition_item
  #has_one :product, :through => :order_item

  validates_presence_of :quantity
  validates_numericality_of :quantity, :greater_than => 0, :integer_only => true
  validate :quantity_not_exceeded

  after_create :update_requisition

  def purchase_order
    requisition_item.requisition.purchase_order
  end

  def assigned_user
    requisition_item.order_item.order.assignee 
  end

  def release_number
    requisition_item.requisition.release_number
  end

  def quantity_not_exceeded
    # ensure less than or equal to req'd quantity
      errors.add_to_base('Cannot receive more items than were purchased') if quantity>requisition_item.order_item.number_receivable
  end

  def update_requisition
    requisition_item.requisition.set_status
    requisition_item.requisition.save
  end

  def to_label
    "#{quantity} x #{requisition_item.order_item.description}"
  end

end
