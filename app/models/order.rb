class Order < ActiveRecord::Base
  
  acts_as_reportable 

  belongs_to :requestor,
    :class_name => "User",
    :foreign_key => "requestor_id"

  belongs_to :manager,
    :class_name => "Contact",
    :foreign_key => "manager_id"
 #   :conditions => "is_manager=1"

  belongs_to :department
  belongs_to :order_type
  belongs_to :project
  belongs_to :pc01
  belongs_to :order_status

  has_many :notes, :as => :notable, :dependent => :destroy
  has_many :order_items, :dependent => :destroy
  has_many :products, :through => :order_items

  validates_presence_of :order_number
  validates_uniqueness_of :order_number

  validates_presence_of :order_type
  validates_presence_of :description
  validates_presence_of :department

  validates_numericality_of :priority, :greater_than => 0, :less_than => 6, 
                            :only_integer => true, :message => 'must be a number between 1 and 5'
  validates_numericality_of :budget_year, :greater_than => 1980, :only_integer => true, :allow_nil => true  
  validates_numericality_of :fund_code, :greater_than => 0, :only_integer => true, :allow_nil => true  
  validates_numericality_of :budget_code, :greater_than => 1000, :only_integer => true, :allow_nil => true  
  #validates_numericality_of :management_center, :greater_than => 99, :less_than => 1000, :only_integer => true, :allow_nil => true  

  validates_associated :order_status

  after_create :save_associated
  after_update :save_associated

  attr_accessor :select_item


  DRAFT = 0
  OPENED = 1
  APPROVED = 2
  PROCESSED = 3
  CLOSED = 7

  def Order.order_type_select
    OrderType.find(:all).map { |t| [t[:name], t[:id]]}
  end

  def display_action?(action)
    return true if self.new_record?
    case action 
      when 'edit' 
        return false unless [OrderStatus.find_by_value(OPENED),OrderStatus.find_by_value(DRAFT)].include? self.order_status
      when 'destroy'
        return false unless [OrderStatus.find_by_value(OPENED),OrderStatus.find_by_value(DRAFT),OrderStatus.find_by_value(APPROVED)].include? self.order_status
      when 'update'
        return false unless [OrderStatus.find_by_value(OPENED),OrderStatus.find_by_value(DRAFT)].include? self.order_status
      when 'requisition'
        return false unless [OrderStatus.find_by_value(APPROVED)].include? self.order_status
      when 'approve'
        return false unless [OrderStatus.find_by_value(OPENED)].include? self.order_status
    end
    return true
  end

  def to_label
    "Order #{order_number}"
  end

  def budget_string
    "#{fund_code}-#{budget_code}-#{management_center}-0000-#{work_order}" 
  end

  def Order.search(q)
    Order.find(:all,:conditions=>['order_number rlike ? or description rlike ? or assignee rlike ? or service_request rlike ?', q, q, q, q])
  end


  def find_all_receiptable_items
    items = []
    order_items.each do |order_item|
      order_item.requisition_items.each do |item|
        items << item if RequisitionItem.find_available_for_receipt.include? item
      end
    end
    return items
  end

  def find_all_distributable_items
    items = []
    order_items.each do |order_item|
      order_item.requisition_items.each do |item|
        items << item if RequisitionItem.find_available_for_distribution.include? item
      end
    end
    return items
  end

  def count_receivable_items
    find_all_receiptable_items.length
  end

  def count_distributable_items
    find_all_distributable_items.length
  end

  def count_unprocessed_items
    unprocessed_order_items.length
  end

  def Order.next_order_number
    if Order.count > 0 
      return Order.maximum('order_number')+1 
    else
      return 1 
    end
  end

  def Order.default_priority
    return 3
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

  def order_item_attributes=(order_item_attributes)
    order_item_attributes.each do |attributes|
      if attributes[:id].blank?
        order_item = order_items.build()
      else
        order_item = order_items.detect { |item| item.id == attributes[:id].to_i }
      end
      order_item.should_destroy = attributes[:should_destroy]
      order_item.product = Product.find(attributes[:product].to_i)
      order_item.quantity = attributes[:quantity].to_i
      order_item.unit_price = attributes[:unit_price].to_f
      order_item.can_substitute = attributes[:can_substitute]
      order_item.details = attributes[:details]
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
    order_items.each do |i|
      if i.should_destroy?
        i.destroy
      else
        i.save(false)
      end
    end 
  end

  def total_cost
    cost=0.0
    order_items.each do |item|
      cost += item.line_price
    end
    return cost
  end

  def project_short
    return nil if !project
    "#{project.project_type_and_number}"
  end

  def requisitions
    reqs=[]
    order_items.each do |item|
      if !item.requisition_items.empty?
        item.requisition_items.each do |i|
          reqs << i.requisition if !reqs.include? i.requisition
        end
      end
    end
    return reqs
  end

  def purchase_orders
    requisitions.map{|r| "#{r.to_label} (#{r.requisition_number}/#{r.purchase_order})"}.to_sentence
  end

  def earliest_purchased_on
    reqs=requisitions.reject{|r| r.purchased_on.nil?}.sort_by{|r| r.purchased_on}
    return nil if reqs.empty?
    reqs.first.purchased_on.to_s
  end

  def total_spent
    cost = 0.0
    order_items.each do |item|
      item.requisition_items.each do |i|
        cost += i.line_price
      end
    end
    return cost.to_f
  end

  def total_price
    cost = 0.0
    return "TBD" if unprocessed?
    order_items.each do |item|
      item.requisition_items.each do |i|
        cost += i.line_price
      end
    end
    return cost.to_f.to_currency
  end

  def access_key
    Digest::MD5.hexdigest(self.to_xml + "LJK__?*&")
  end

  def unprocessed_order_items
    order_items.select {|item| item.number_remaining>0}
  end

  def unprocessed?
    order_items.each do |item|
      return true if item.number_remaining>0 
    end
    return false
  end

  def processed?
    !unprocessed?
  end

  def all_distributed?
    #return true unless order_items.reject{|item| item.quantity==item.quantity_distributed}.length > 0
    return true unless count_distributable_items > 0
    false
  end

  def set_status
    self.order_status=OrderStatus.find_by_value(Order::CLOSED) if self.all_distributed?
    self.closed_on = Time.now if self.all_distributed? and self.closed_on.blank?
  end

  def approve(name)
    return false if self.order_items.empty?
    self.order_status = OrderStatus.find_by_value(Order::APPROVED)
    self.approved_on = Date.today.to_s
    self.is_approved = true
    self.approved_by = name
    Notifier.deliver_order_notify(Contact.find_by_last_name('Manez'), self) if self.requestor.contact.employee_of?(Contact.find_by_last_name('Manez'))
    Notifier.deliver_order_notify(Contact.find_by_last_name('Buccieri'), self) if self.order_type == OrderType.find_by_name('Software')
  end

  def self.find_and_notify_unapproved_orders
    orders = []
    notify =[]
    Order.find_all_by_order_status_id(OrderStatus.find_by_value(Order::OPENED)).each do |order|
      orders << order
      notify << order.requestor.contact.manager
    end
    notify.uniq!
    notify.each do |manager|
      notify_orders = orders.select {|order| order.requestor.contact.manager==manager}
      Notifier.deliver_outstanding_approvals(manager, notify_orders) unless notify_orders.length == 0
    end
  end

  protected

  def validate
    errors.add_to_base('You have not added any order items') if order_items.empty? and order_status != OrderStatus.find_by_value(Order::DRAFT)
  end

end
