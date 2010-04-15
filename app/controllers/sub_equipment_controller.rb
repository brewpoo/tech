class SubEquipmentController < ApplicationController

  active_scaffold :equipment do |config|
    columns.add :product_full_name, :children
    list.columns = [:product_full_name, :serial_number, :tag_number, :count]
    show.columns = [:product_full_name, :serial_number, :tag_number, :count]
    create.columns = update.columns = [:parent, :product, :serial_number, :tag_number, 
                    :delivery_date, :count]
    list.sorting = { :device => :asc }
    list.per_page = 50
    columns[:product_full_name].label = 'Product'
    columns[:product].form_ui = :select
    columns[:children].association.reverse = :parent
    # Searching and sorting
    columns[:product_full_name].sort_by :sql => 'products.full_name'
    columns[:product_full_name].search_sql = 'products.full_name'
    search.columns << [:product_full_name]
  end

end
