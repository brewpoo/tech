class InventoryController < ApplicationController

  active_scaffold :equipment do |config|
    actions.exclude :create
    columns.add :product_full_name
    list.columns = [:product_full_name, :location, :role, :serial_number, :tag_number, :count]
    list.label = "Inventory"
    list.sorting = {:product_full_name => :asc}
    list.per_page =  50 
    show.columns = [:product_full_name, :location, :role, :equipment_status, :serial_number, :tag_number, :count]
    columns[:product_full_name].label = 'Product'
    update.columns = [:product, :location, :role, :serial_number, :tag_number, :host_identifier, :equipment_status,
      :delivery_date, :count]
    columns[:equipment_status].form_ui = :select
    columns[:parent].form_ui = :select
    columns[:product].form_ui = :select
    columns[:location].form_ui = :select
    columns[:role].form_ui = :select
    action_links.add('check_in', :label => 'Check In', :type => :table, :crud_type => :create, :inline => false)
    action_links.add('check_out', :label => 'Check Out', :type => :table, :crud_type => :update, :inline => false)
    # Search and Sort
    columns[:product_full_name].includes = [:product]
    columns[:product_full_name].search_sql = "products.full_name"
    columns[:product_full_name].sort_by :sql => 'products.full_name'
    search.columns << [:product_full_name]
    # Filters
    config.actions.add :list_filter
    config.list_filter.add(:association, :role, {:label => "Group", :association => [:role]})
  end

  def conditions_for_collection
    ['equipment.equipment_status_id = ?', EquipmentStatus.find_by_flag('stock')]
  end

  def return_to_main
    redirect_to :action => 'list'
  end

  #
  # AJAX Responses
  #

  def manufacturer_changed
    return unless request.xhr?
    @product_families = ProductFamily.find_by_manufacturer(params[:id]).map { |m| [m.name, m.id]}
    render_js
  end

  def product_family_changed
    return unless request.xhr?
    @products = Product.find_by_product_family(params[:id]).map { |m| [m.name, m.id]}
    render_js
  end

  def new_manfacturer
    return unless request.xhr?
    render_js
  end

  def add_manufacturer
    if request.post?
      @manufacturer = Company.new(:name => params[:name], :is_manufacturer => true)
      @manufacturer.url = params[:url] unless params[:url].nil?
      @manufacturer.save
      if !@manufacturer.new_record?
        flash[:notice] = "Manufacturer #{@manufacturer.name} Added"
      else
        flash[:notice] = 'Failed to add manufacturer'
      end
      @manufacturers = Company.find_manufacturers.map { |m| [m.name, m.id] }
      @product_families = Array.new
      render_js
    end
  end

  def add_product_family
    if request.post?
      @product_family = ProductFamily.new(:name => params[:name], :manufacturer => Company.find(params[:manufacturer]))
      @product_family.save
      if !@product_family.new_record?
        flash[:notice] = "Product Family #{@product_family.name} Added"
      else
        flash[:notice] = 'Failed to add product family'
      end
      @product_families = ProductFamily.find_by_manufacturer(params[:manufacturer]).map { |m| [m.name, m.id]}
      @products = Array.new
      render_js
    end
  end

  def new_product_family
    return unless request.xhr?
    if params[:manufacturer].to_i == 0
      flash[:notice] = "You must select a manufacturer first!"
      render :update do |page|
        page['order-form-messages'].show
        page.replace_html 'order-form-messages', flash[:notice]
        flash[:notice] = nil
        page.visual_effect :fade, 'order-form-messages', :duration => 5
      end
    else
      @product_family = ProductFamily.new(:manufacturer => Company.find(params[:manufacturer]))
      render_js
    end
  end

  def new_product
    return unless request.xhr?
    if params[:product_family].to_i == 0
      flash[:notice] = "You must select a product family first!"
      render :update do |page|
        page['order-form-messages'].show
        page.replace_html 'order-form-messages', flash[:notice]
        flash[:notice]=nil
        page.visual_effect :fade, 'order-form-messages', :duration => 5
      end
    else
      @product = Product.new(:product_family => ProductFamily.find(params[:product_family]))
      @architectures = tree_select_map(Architecture.find(:all,:conditions=>'parent_id is null',:order=>'name'),0)
      @device_classes = tree_select_map(DeviceClass.find(:all,:conditions=>'parent_id is null',:order=>'name'),0)
      render_js
    end
  end

  def add_product
    if request.post?
      @product = Product.new
      @product.name = params[:name]
      unless params[:device_class].first.empty?
        @product.device_class = DeviceClass.find(params[:device_class].first.to_i)
      end
      @product.product_family = ProductFamily.find(params[:product_family])
      unless params[:architecture].first.empty?
        @product.architecture = Architecture.find(params[:architecture].first.to_i)
      end
      @product.model_number = params[:model_number]
      @product.part_number = params[:part_number]
      @product.spare_number = nil || params[:spare_number]
      @product.description = nil || params[:description]
      @product.detailed = false || params[:detailed]
      @product.save
      if !@product.new_record?
        flash[:notice] = "Product #{@product.name} Added"
      else
        flash[:notice] = 'Failed to add product'
      end
      @products = Product.find_by_product_family(params[:product_family]).map { |m| [m.name, m.id]}
      render_js
    end

  end

  def add_inventory_item
    return unless request.xhr?
    if params[:product].to_i == 0
      render_flash "You must select a product first!"
    else
      count = params[:count] || 1
      @product=Product.find(params[:product])
      count = @product.detailed ? 1 : params[:count]
      @number = @product.detailed ? params[:count] : 1
      count = 1 if count.nil? or count == 0
      @equipment=Equipment.new(:product=>@product, :count => count)
      render_js
    end
  end

  def check_in
    if request.post?
      Equipment.transaction do
        status = EquipmentStatus.find_by_flag('stock')
        location = Location.find(params[:check_in][:location])
        role = Role.find(params[:check_in][:role])
        params[:inventory_items].each do |item|
          product = Product.find(item[:product])
          if product.detailed
            equipment = Equipment.new(:product => product, :count => 1, 
                      :equipment_status => status, :location => location, :role => role)
            equipment.serial_number = item[:serial_number] unless item[:serial_number].blank? 
            equipment.tag_number = item[:tag_number] unless item[:tag_number].blank? 
            equipment.save!
          else
            equipment = Equipment.find(:first, :conditions => ['equipment_status_id = ? and location_id = ? and product_id = ?',
              status.id, location.id, product.id]) || Equipment.new(:product => product, :count => item[:count],
                      :equipment_status => status, :location => location, :role => role)
            equipment.count += item[:count].to_i unless equipment.new_record?
            equipment.save
          end
        end
      end
      redirect_to :action => 'list' and return
    end
  end

  def search_location
    return unless request.xhr?
    @equipment= Equipment.find(:all,:conditions=>['location_id = ? and equipment_status_id = ?',
                                     Location.find(params[:id]),EquipmentStatus.find_by_flag('stock')])
    render_js
  end

  def search
    return unless request.xhr?
    render_flash "Please enter an item to search for" and return if params[:q].blank?
    stock = Equipment.find(:all,:conditions=>['equipment_status_id=?',EquipmentStatus.find_by_flag('stock')])
    @equipment = []
    [Product,ProductFamily,Company].each do |klass|
      klass.search(params[:q]).each do |result|
        @equipment << result.find_all_stock_items
      end
    end
    @equipment.flatten!
    @equipment.uniq!
    if @equipment.length == 0 
      render_flash "No results found"
    else
      render_js
    end
  end
    

  def check_out_item
    return unless request.xhr?
    @item = Equipment.find(params[:id])
    @item.check_out_quantity = params[:check_out_quantity].to_i
    render_js
  end

  def check_out
    if request.post?
      Equipment.transaction do
        status = EquipmentStatus.find(params[:check_out][:equipment_status])
        location = Location.find(params[:check_out][:location])
        params[:check_out_items].each do |item|
          equipment = Equipment.find(item[:id])
          if item[:check_out_quantity].to_i < equipment.count and !equipment.product.detailed
            equipment.update_attribute(:count,equipment.count-item[:check_out_quantity].to_i)
            new_equipment=Equipment.create(:product => equipment.product, :location => location,
               :equipment_status => status, :count => item[:check_out_quantity])
          else
            equipment.update_attribute(:location,location)
            equipment.update_attribute(:equipment_status,status)
          end
        end
      end
      redirect_to :action => 'list' and return
    end
  end

end
