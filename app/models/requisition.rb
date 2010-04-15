class Requisition < ActiveRecord::Base

  acts_as_reportable

  belongs_to :vendor, 
    :class_name => "Company",
    :foreign_key => "vendor_id"

  belongs_to :processor,
    :class_name => "User",
    :foreign_key => "processor_id"

  has_many :requisition_items, :dependent => :destroy
  has_many :order_items, :through => :requisition_items
  has_many :products, :through => :order_items
  belongs_to :requisition_status

  has_many :notes, :as => :notable, :dependent => :destroy

  before_validation_on_create :set_release_number
  before_save :set_status
  after_create :save_associated
  after_update :save_associated
  before_destroy :unprocess_order

#  validates_uniqueness_of :requisition_number, :allow_nil => true
#  validates_numericality_of :requisition_status, :greater_than_or_equal => 0, :integer_only => true  
  validates_presence_of :release_number
  validates_uniqueness_of :release_number

  validates_associated :requisition_status

  # Needed to handle state transitions
  attr_accessor :requisition_number_was, :vendor_was, :purchase_order_was, :is_pcard_purchase_was

  INITIAL = 0
  CREATED = 1
  BIDDING = 2
  AWARDED = 3
  PURCHASED = 4
  SHIPPING = 5
  CLOSED = 6
 

  def display_action?(action)
    return true if self.new_record?
    case action
      #when 'edit'
      #  return false if self.requisition_status==RequisitionStatus.find_by_value(CLOSED)
      when 'destroy'
        return false unless [RequisitionStatus.find_by_value(INITIAL),RequisitionStatus.find_by_value(BIDDING)].include? self.requisition_status
      when 'request_bid'
        return false unless [RequisitionStatus.find_by_value(INITIAL),RequisitionStatus.find_by_value(BIDDING)].include? self.requisition_status
    end
    return true
  end

  def to_label
    return release_number.to_s unless release_number.blank?
    return requisition_number.to_s unless requisition_number.blank?
    return "#{id}-#{created_on.to_s}-#{processor.username}"
  end

  def days_old
    return ((Time.now - created_on.to_time)/86400).round
  end

  def Requisition.find_available
    Requisition.find(:all,:conditions=>['requisition_status_id=?',RequisitionStatus.find_by_value(Requisition::INITIAL).id])
  end

  def Requisition.search(q)
    Requisition.find(:all,:conditions=>['requisition_number rlike ? or purchase_order rlike ? or release_number rlike ?', q, q, q]) 
  end

  def find_all_receiptable_items
    items = []
    requisition_items.each do |item|
      items << item if RequisitionItem.find_available_for_receipt.include? item
    end
    return items
  end

  def find_all_distributable_items
    items=[]
    requisition_items.each do |item|
      items << item if RequisitionItem.find_available_for_distribution.include? item
    end
    return items
  end

  def any_received?
    return true if requisition_items.select{|item| item.received_items}.length > 0
    false
  end

  def all_received?
    return true unless requisition_items.reject{|item| item.quantity==item.quantity_received}.length > 0
    false
  end

  def total_cost
    cost=0.0
    requisition_items.each do |item|
      cost += item.line_price
    end
    return cost
  end

  def orders
    orders=[]
    requisition_items.each do |item|
      orders << item.order_item.order if !orders.include? item.order_item.order
    end
    return orders
  end

  def note_attributes=(note_attributes)
    note_attributes.each do |attributes|
      if attributes[:id].blank?
        notes.build(attributes)
      else
        note = notes.detect { |note| note.id == attributes[:id].to_i }
        note.attributes = attributes
      end
    end
  end

  def requisition_item_attributes=(requisition_item_attributes)
    requisition_item_attributes.each do |attributes|
      item = requisition_items.detect { |item| item.id == attributes[:id].to_i }
      item.unit_price = attributes[:unit_price].to_f
      item.details = attributes[:details]
      item.should_destroy = attributes[:should_destroy].to_i
    end
  end

  def unprocess_order
    orders.each do |order|
      order.update_attribute(:order_status,OrderStatus.find_by_value(Order::APPROVED))
    end
  end

  def save_associated
    notes.each do |n|
      if n.should_destroy?
        n.destroy
      else
        n.save(false)
      end
    end
    requisition_items.each do |i|
      if i.should_destroy?
        i.destroy
      else
        i.save(false)
      end
    end
  end

  def set_status
    self.requisition_status=RequisitionStatus.find_by_value(CREATED) if self.requisition_number? 
    self.requisitioned_on = Time.now if self.requisition_number_was.blank? and self.requisition_number?
    self.requisition_status=RequisitionStatus.find_by_value(BIDDING) if self.sent_emails? 
    self.requisition_status=RequisitionStatus.find_by_value(AWARDED) if self.vendor
    self.awarded_on = Time.now if self.vendor_was.blank? and self.vendor
    self.requisition_status=RequisitionStatus.find_by_value(PURCHASED) if self.purchase_order? or self.is_pcard_purchase?
    self.purchased_on = Time.now if self.purchase_order_was.blank? and self.purchase_order?
    self.purchased_on = Time.now if self.is_pcard_purchase_was.blank? and self.is_pcard_purchase?
    self.requisition_status=RequisitionStatus.find_by_value(SHIPPING) if self.any_received?
    self.requisition_status=RequisitionStatus.find_by_value(CLOSED) if self.all_received?
  end

  def set_release_number
    self.release_number = Requisition.next_release_number
  end

  def Requisition.next_release_number
    if Requisition.count > 0
      return "HW-#{(Requisition.maximum('release_number').split('-')[1].to_i+1).to_s.rjust(4,'0')}"
    else
      return 'HW-0001'
    end
  end

  def Requisition.find_and_update_po
    logger.debug("Here")
    missing_reqs=[]
    mismatched_reqs=[]
    updated_reqs=[]
    Requisition.find(:all,:conditions=>["requisition_number <> '' and requisition_status_id < 10"]).each { |req|
      logger.debug("Checking #{req.requisition_number}")
      pls_req, pls_po = PlsRequisition.get_purchase_order req
      if pls_req == nil
        # Handle unmatched requisition here
        logger.debug("Unmatched requisition #{req.requisition_number}")
        missing_reqs << req
        next
      end
      if pls_po == req.purchase_order
        # Found matching PO
        logger.debug("Found matching PO for #{req.requisition_number}")
      else
        if req.purchase_order == ''
          # New PO Update
          logger.debug("Found new PO for #{req.requisition_number} => #{req.purchase_order}")
          req.update_attribute(:purchase_order,pls_po)
          updated_reqs << req
        else
          # Unmatched PO
          logger.debug("Found non-matching PO for #{req.requisition_number}, #{req.purchase_order} should be #{pls_po}")
          mismatched_reqs << req 
        end
      end
    }
    if missing_reqs.length > 0 or mismatched_reqs.length > 0 or updated_reqs > 0
      Notifier.deliver_bad_reqs(Contact.find_by_last_name('Lochner'),missing_reqs, mismatched_reqs, updated_reqs)
    end 
  end

end
