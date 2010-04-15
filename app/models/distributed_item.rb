class DistributedItem < ActiveRecord::Base

  belongs_to :order_item, :include => :product
  belongs_to :contact
  belongs_to :processor,
    :class_name => "User",
    :foreign_key => "processor_id"

  has_many :notes, :as => :notable

  validates_presence_of :quantity
  validates_numericality_of :quantity, :greater_than => 0, :integer_only => true

  validates_presence_of :contact
  validates_associated  :contact
  validate :quantity_not_exceeded

  after_create :update_order

  def quantity_not_exceeded
    # ensure less than or equal to req'd quantity
    errors.add_to_base('Cannot distribute more items than were received') if quantity>order_item.number_distributable
   end
    
   def update_order
     order_item.order.set_status
     order_item.order.save!
   end

  def to_label
    "#{quantity} x #{order_item.description}"
  end


end
