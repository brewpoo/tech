class ProductFamily < ActiveRecord::Base

  acts_as_reportable

  belongs_to :manufacturer, :class_name => "Company", 
             :foreign_key => "manufacturer_id", :conditions => 'is_manufacturer=1'
  has_many :products
  after_update :update_product_full_names

  validates_uniqueness_of :name, :scope => 'manufacturer_id'

  def to_label
    "#{name}"
  end

  def full_name
    "#{manufacturer.name} #{name}"
  end

  def update_product_full_names
    if products
      products.each do |product|
        product.update_attribute :full_name, product.set_full_name
      end
    end
  end

  def ProductFamily.find_by_manufacturer(id)
    ProductFamily.find(:all,:conditions=>["manufacturer_id=?",id],:order=>'name')
  end

  def ProductFamily.search(q)
    ProductFamily.find(:all,:conditions=>['name rlike ?', q])
  end

  def self.unused
    ProductFamily.find(:all).select{|p|!p.products}
  end

  def find_all_receiptable_items
    items = []
    products.each do |product|
      items << product.find_all_receiptable_items
    end
    return items.flatten
  end

  def find_all_distributable_items
    items = []
    products.each do |product|
      items << product.find_all_distributable_items
    end
    return items.flatten
  end

  def find_all_stock_items
    items = []
    products.each do |product|
      items << product.find_all_stock_items
    end
    return items.flatten
  end

  def ProductFamily.remove_unused_families
    ProductFamily.find(:all).each do |family|
      next if family.products
      family.destroy
    end
  end



end
