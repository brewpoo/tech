class Product < ActiveRecord::Base

  acts_as_reportable

  belongs_to :device_class
  belongs_to :product_family, :include => :manufacturer
  belongs_to :architecture

  has_many :equipment
  has_many :product_properties
  has_many :order_items

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => "product_family_id"

#  validates_format_of :name, :with => /^((p){1}[\/]{1}(n){1})/i, :message => 'may not contain part number, please specify part number in the correct field'

  before_save :update_full_name
  before_destroy :check_for_dependents

  def check_for_dependents
    if !order_items.empty? or !equipment.empty?
      self.errors.add "Cannont delete, there are associated order items or equipment"
      return false
    end
    return true
  end

  def manufacturer_name
   product_family.manufacturer.name if product_family && product_family.manufacturer
  end
  
  def family_name
    product_family.name if product_family
  end

  def product_name
    "#{family_name} #{name}"
  end

  def old_full_name
    "#{manufacturer_name} #{product_name}"
  end
  
  def set_full_name
    "#{manufacturer_name} #{product_name}"
  end

  def update_full_name
    self.full_name=self.set_full_name
  end

  def part
    return "#{part_number} #{description}" unless part_number.blank?
    "#{description}"
  end

  def to_label
    full_name
  end
  def Product.find_by_product_family(id)
    Product.find(:all,:conditions => ['product_family_id=?',id],:order=>'name')
  end

  def Product.search(q)
    Product.find(:all,:conditions=>['model_number rlike ? or part_number rlike ? or description rlike ?', q, q, q])
  end

  def Product.all_products
    Product.find(:all).sort_by{|p| p.full_name}.map{|p|  ["#{p.full_name}", p.id]}
  end

  def Product.all_select
    all_products = CACHE.get("all_products")
    if all_products == nil
      Product.run_precache
      all_products = CACHE.get("all_products")
    end
    return all_products
  rescue
    return Product.all_products
  end

  def Product.used_products
    Product.find(:all).select{|p| p.equipment}.sort_by{|p|p.full_name}.map{|p| ["#{p.full_name}", p.id]}
  end

  def Product.used_select
    used_products = CACHE.get("used_products")
    if used_products == nil
      Product.run_precache
      used_products = CACHE.get("used_products")
    end
    return used_products
  rescue
    return Product.used_products
  end

  def Product.server_products
    Product.find(:all, :conditions => ['device_class_id=?',DeviceClass.find_by_name("Server")]).sort_by{|p|p.full_name}.map{|p| ["#{p.full_name}",p.id]}
  end

  def Product.server_select
    server_products = CACHE.get("server_products")
    if server_products == nil
      Product.run_precache
      server_products = CACHE.get("server_products")
    end
    return server_products
  rescue
    return Product.server_products
  end

  def self.run_precache
    CACHE.set("used_products",Product.used_products)
    CACHE.set("server_products",Product.server_products)
    CACHE.set("all_products",Product.all_products)
  end


  def find_all_receiptable_items
    items=[]
    order_items.each do |order_item|
      order_item.requisition_items.each do |item|
        items << item if RequisitionItem.find_available_for_receipt.include? item
      end
    end
    return items
  end

  def find_all_distributable_items
    items=[]
    order_items.each do |order_item|
      order_item.requisition_items.each do |item|
        items << item if RequisitionItem.find_available_for_distribution.include? item
      end
    end
    return items
  end

  def find_all_stock_items
    items=[]
    equipment.each do |item|
      items << item if Equipment.find_stock_items.include? item
    end
    return items
  end 

  def latest_price
    return nil if order_items.empty?
    item=order_items.sort_by{|i| i.order.ordered_on}.first
    return item.unit_price.to_f if item.requisition_items.empty?
    return item.requisition_items.first.unit_price.to_f
  end

  def validate
    errors.add_to_base("Name should not contain a part number, please use the correct field") if name.match(/((p){1}[\/]{1}(n){1})/i)
  end


end
