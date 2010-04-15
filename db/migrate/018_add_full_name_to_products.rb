class AddFullNameToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :full_name, :text
    Product.reset_column_information
    Product.find(:all).each do |product|
      product.update_attribute :full_name, product.old_full_name
    end

  end

  def self.down
    remove_column :products, :full_name
  end
end
