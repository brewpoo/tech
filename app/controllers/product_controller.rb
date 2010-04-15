class ProductController < ApplicationController

  active_scaffold :product do |config|
    columns.add :manufacturer_name
    list.columns = [:full_name, :device_class, :description, :part_number]
    create.columns = update.columns = [:product_family, :name, :device_class, :description, :model_number,
                    :part_number, :spare_number, :detailed]
    show.columns = [:manufacturer_name, :product_family, :name, :device_class, :description, :model_number, :part_number, :spare_number, :detailed, :equipment, :order_items]
    list.per_page = 50
    columns[:detailed].form_ui = :checkbox
    columns[:device_class].form_ui = :select
    list.sorting = {:full_name => :asc}
    action_links.add('merge_products', :label => 'Merge Products', :type => :table, :crud_type => :update, :inline => false)
    nested.add_link("Properties", [:product_properties])
    # Filters
    config.actions.add :list_filter
    config.list_filter.add(:association, :device_class, {:label => "Device Class", :association => [ :device_class ] })
  end

  def merge_products
    @products=Product.find(:all).sort_by{|p| p.full_name}.map{|p| ["#{p.full_name} [#{p.part_number}] (#{p.order_items.count})", p.id]}
    if request.post?
      from=Product.find(params[:merge_from][:id].to_i)
      to=Product.find(params[:merge_to][:id].to_i) 
      if from.equipment
        from.equipment.each do |e|
          e.product=to
          e.save
        end
      end
      if from.order_items
        from.order_items.each do |o|
          o.product=to
          o.save
        end
      end
      from.destroy
      flash[:notice]="Products have been merged"
      redirect_to :action => 'list' and return
    end
  end

  def all_products
    return unless request.xhr?
    @products = Product.all_select
    render_js
  end


end
