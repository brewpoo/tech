class Company < ActiveRecord::Base

  acts_as_reportable

  belongs_to :contact #Primary
  has_many :contacts, :foreign_key => 'employer_id'
  has_many :circuits, :foreign_key => 'provider_id'
  has_many :product_families, :foreign_key => 'manufacturer_id', :dependent => :destroy
  has_many :requisitions, :foreign_key => 'vendor_id'
  belongs_to :purchase_contact, :class_name => 'Contact',
            :foreign_key => 'purchase_contact_id'
  has_many :purchase_contacts, :class_name => 'Contact',
    :foreign_key => 'employer_id', :conditions => 'contacts.is_purchase_contact = 1'
  
  has_many :phones, :as => :phonable, :dependent => :destroy
  has_many :notes, :as => :notable, :dependent => :destroy

  has_many :departments

  after_update :set_product_full_names

  validates_presence_of :name
  validates_uniqueness_of :name
  
  validates_presence_of :bpo_expiry, :if => Proc.new { |company| company.bpo }

  def to_label
    "#{name}"
  end

  def manufacturer?
    is_manufacturer
  end

  def vendor?
    is_vendor
  end

  def provider?
    is_provider
  end

  def set_product_full_names
    if is_manufacturer? and product_families
      product_families.each do |family|
        family.products.each do |product|
          product.update_attribute :full_name, product.set_full_name
        end
      end
    end
  end

  def Company.map_select
    Company.find(:all, :order=>'name').map { |c| [c.name, c.id] }
  end

  def Company.find_manufacturers
    Company.find(:all, :conditions => 'is_manufacturer=1', :order=>'name')
  end

  def Company.manufacturers_select
    Company.find_manufacturers.map { |m| [m.name, m.id] }
  end

  def Company.find_vendors
    Company.find(:all, :conditions => 'is_vendor=1', :order=>'name')
  end

  def Company.vendors_select
    Company.find_vendors.map { |v| [v.name, v.id] }
  end

  def departments_select
    departments.sort_by{|d| d.name}.map { |d| [d.name, d.id] }
  end

  #def purchase_email
  #  purchase_contact.email if has_purchase_contact?
  #end

  def Company.search(q)
    Company.find(:all,:conditions=>['name rlike ?', q])
  end

  def find_all_receiptable_items
    items = []
    if is_manufacturer
      product_families.each do |family|
        items << family.find_all_receiptable_items
      end
    end
    if is_vendor
      requisitions.each do |requisition|
        items << requisition.find_all_receiptable_items
      end      
    end
    return items.flatten
  end

  def find_all_distributable_items
    items = []
    if is_manufacturer
      product_families.each do |family|
        items << family.find_all_distributable_items
      end
    end
    if is_vendor
      requisitions.each do |requisition|
        items << requisition.find_all_distributable_items
      end
    end
    return items.flatten
  end

  def find_all_stock_items
    items = []
    if is_manufacturer
      product_families.each do |family|
        items << family.find_all_stock_items
      end
    end
    return items.flatten

  end

end
