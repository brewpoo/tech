class OrderController < ApplicationController

  before_filter :setup_active_scaffold, :except => :remote_approve
  
      active_scaffold :order do |config|
        columns.add :project_short, :total_cost, :requisitions, :products, :budget_string
        list.columns = [:order_number, :ordered_on, :order_type, :project, :service_request, :description, :requestor, 
          :total_cost, :order_status, :requisitions]
        list.sorting = {:ordered_on => :desc}
        list.per_page = 50
        columns[:ordered_on].label = 'Date Ordered'
        columns[:total_cost].label = 'Estimate Cost'
        create.columns = [:description, :notes]
        update.columns = [:description, :notes]
        action_links.add('clone_order', :label => 'Clone Order', :type => :table, :crud_type => :create, :inline => false)
        # Sorting and Searching
        columns[:order_status].sort_by :sql => 'order_statuses.value'
        columns[:total_cost].sort_by :method => 'total_cost'
        columns[:project_short].includes = [:project]
        columns[:project_short].search_sql = "projects.project_number"
        columns[:project].search_sql = "projects.title"
        columns[:order_type].search_sql = "order_types.name"
        columns[:requisitions].sort_by :method => 'requisitions.empty? ? String.new : requisitions[0].release_number'
        columns[:order_items].includes = [:products]
        columns[:order_items].search_sql = "order_items.details"
        columns[:products].search_sql = "products.full_name"
        columns[:project]. sort_by :sql => 'project_type_id, project_number'
        search.columns << [:order_type, :project_short, :project, :order_items, :products]
        # Filters
        config.actions.add :list_filter
        config.list_filter.add(:association, :order_status, {:label => "Order Status", :association => [:order_status]})
        config.list_filter.add(:association, :requestor, {:label => "Requestor", :association => [ :requestor ] })
        config.list_filter.add(:association, :order_type, {:label => "Order Type", :association => [:order_type]})
        config.list_filter.add(:association, :project, {:label => "Project", :association => [:project]})
        config.list_filter.add(:association, :manager, {:label => "Manager", :association => [:manager]})
        # Other stuff
        show.columns = [:order_number, :ordered_on, :requestor, :order_type, :priority, :order_status, :approved_by, :approved_on,
          :description, :project, :justification, :department, :assignee, :budget_year, :budget_string, :service_request, :department_control_number, 
          :related_pc01, :order_items, :total_cost, :notes, :closed_on]
        config.create.link.page = true
        config.update.link.page = true 
        columns[:service_request].inplace_edit = true
      end

  def setup_active_scaffold
      if this_user.has_role?('purchase_processor')
        active_scaffold_config.action_links.add('requisition',
                                              :label => 'Process',
                                              :type => :record,
                                              :crud_type => :create,
                                              :inline => false)
      else
        active_scaffold_config.actions.exclude('requisition')
      end
      if this_user.has_role?('purchase_approver')
        active_scaffold_config.action_links.add('approve',
                                                :label => 'Approve',
                                                :type => :record,
                                                :crud_type => :update,
                                                :inline => false,
                                                :confirm => 'Approve this order?')
      else
        active_scaffold_config.actions.exclude('approve')
      end
  end

  def pconditions_for_collection
    ['order_status < ?', Order::CLOSED ]
  end

  def edit
    @order=Order.find(params[:id])
    if @order.order_status.value < Order::APPROVED
      super
    else
      flash[:warning]="This order cannot be edited"
    end
  end

  def clone_order
    @order_select=Order.find(:all,:conditions=>['ordered_on > ?', Time.now-365.days]).sort_by{|o| o.ordered_on}.map {|o| ["#{o.order_number}-#{o.description}",o.id] }
    if request.post?
      order=Order.find(params[:order][:id])
      @clone_order=Order.new
      @clone_order.description=params[:order][:description]
      @clone_order.department=order.department
      @clone_order.priority=order.priority
      @clone_order.order_type=order.order_type
      @clone_order.ordered_on = Date.today.to_s
      @clone_order.requestor = this_user
      @clone_order.manager=order.manager
      @clone_order.order_status = OrderStatus.find_by_value(Order::DRAFT)
      @clone_order.order_number = Order.next_order_number
      order.order_items.each do |item|
        @clone_order.build_to_order_items(:product=>item.product,:quantity=>item.quantity,:unit_price=>item.unit_price,
                        :can_substitute=>item.can_substitute,:details=>item.details)
      end
      @clone_order.save!
      redirect_to :action => 'list' and return
    end
  end

  def closeout
    if request.post?
      message = ""
      params[:select_item].each do |order|
        o=Order.find(order.first)
        message << "#{o.order_number} "
        # Mark all receivable as received
        o.find_all_receiptable_items.each do |receivable|
          next unless receivable.number_receivable>0
          receivable.create_in_received_items(:quantity => receivable.number_receivable, :received_on => Time.now,
            :receiver => User.current_user)
        end
        # Mark all deliverable as delivered
        o.find_all_distributable_items.each do |distributable|
          next unless distributable.number_distributable>0
          distributable.order_item.create_in_distributed_items(:quantity => distributable.number_distributable, :distributed_on => Time.now,
              :processor => User.current_user, :contact => User.current_user.contact)
        end
        o.order_status=OrderStatus.find_by_value(Order::CLOSED)
        o.closed_on = Time.now
        o.save!
      end
      flash[:notice]="Order (#{message}) has been closed"
      #redirect_to :action => 'list' and return
    end
    @closeout_items=Order.find(:all,:conditions=>'order_status_id=4')
  end


  def create
    @order = Order.new
    @order.requestor = this_user
    if params[:commit]=='Save Draft' then
      @order.order_status = OrderStatus.find_by_value(Order::DRAFT)
      message = "Draft Created"
    else
      @order.order_status = OrderStatus.find_by_value(Order::OPENED)
      @order.approve(this_user.contact.full_name) if this_user.has_role?('purchase_processor') || (this_user.has_role?('purchase_approver') && !this_user.contact.manager)
      message = "Order Created"
    end
    @order.priority = Order.default_priority
    @order.order_number = Order.next_order_number
    @order.ordered_on = Date.today.to_s
    #
    if @order.update_attributes(params[:order])
      Notifier.deliver_order_created(@order.manager || @order.requestor.contact.manager, @order) if @order.order_status == OrderStatus.find_by_value(Order::OPENED) and this_user.contact.manager
      Notifier.deliver_order_approved(@order.order_type.processor.contact, @order) if @order.order_status == OrderStatus.find_by_value(Order::APPROVED)
      #redirect_to :action => 'list'
      render :action => 'order_created'
    else
      render(:action => 'create_form', :layout => true)
    end
  end

  def update
    @order = Order.find(params[:id])
    if params[:commit]=='Update Draft' then
      @order.order_status = OrderStatus.find_by_value(Order::DRAFT)
    else
      @order.order_status = OrderStatus.find_by_value(Order::OPENED)
      @order.approve(this_user.contact.full_name) if this_user.has_role?('purchase_processor') || (this_user.has_role?('purchase_approver') && !this_user.contact.manager)
    end
    if @order.update_attributes(params[:order])
      Notifier.deliver_order_created(@order.manager || @order.requestor.contact.manager, @order) if @order.order_status == OrderStatus.find_by_value(Order::OPENED) and this_user.contact.manager
      Notifier.deliver_order_approved(@order.order_type.processor.contact, @order) if @order.order_status == OrderStatus.find_by_value(Order::APPROVED)
      #redirect_to :action => 'list'
      render :action => 'order_updated'
    else
      render(:action => 'update_form', :layout => true)
    end
  end

  def requisition
    @order=Order.find(params[:id])
    if @order.order_status == OrderStatus.find_by_value(Order::APPROVED)
      if request.post?
        if params[:requisition][:id].to_i > 0
          @requisition = Requisition.find(params[:requisition][:id])
        else
          @requisition = Requisition.new 
          @requisition.management_center = params[:management_center]
        end
        @requisition.created_on = Time.now
        @requisition.processor=this_user
        @requisition.requisition_status = RequisitionStatus.find_by_value(Requisition::INITIAL)
        params[:requisition_item].each do |key,item|
          @requisition.build_to_requisition_items(:quantity => item[:quantity], :order_item => OrderItem.find(key.to_i)) unless item[:quantity].to_i==0
        end
        if @requisition.save! and @order.processed?
          @order.order_status = OrderStatus.find_by_value(Order::PROCESSED)
          @order.save
        end
        render :action => 'requisition_created'
      end
    end
  end

  #
  # Order can only be approved by the requestor
  # or one of the requestor's managers
  def approve
    @order=Order.find(params[:id])
    if @order.order_status == OrderStatus.find_by_value(Order::OPENED) 
      if this_user.contact.manager_of?(@order.requestor.contact.id)
        @order.approve(this_user.contact.full_name)
        if @order.save
          Notifier.deliver_order_approved(@order.order_type.processor.contact, @order)
          flash[:info]="Order Approved"
        end
        return redirect_to :back
      else
        flash[:warning]="Only the requestor's managers can approve this order!"
        return redirect_to :back
      end
    else
      flash[:error]="Order is not able to be approved"
      return redirect_to :back
    end
  end

  def remote_approve 
    @order=Order.find(params[:id])
    return redirect_to :action => 'list' unless params[:key]==@order.access_key
    @order.approve(@order.requestor.contact.manager.full_name)
    if @order.save
      Notifier.deliver_order_approved(@order.order_type.processor.contact, @order)
      flash[:info]="Order Approved"
    end
    return redirect_to :action => 'list'
  end

  #
  # ActiveScaffold overrides
  #

  #
  # Get's rid of ugly parameters in url
  def return_to_main
    redirect_to :action => 'list'
  end

  #
  # Not 100% necessary, could do @order = @record in the template overrride
  def do_new
    @order = Order.new(:department => this_user.contact.department, :manager => this_user.contact.manager, :requestor => this_user,
      :budget_year => Time.now.year, :fund_code => this_user.contact.manager.fund_code, :budget_code => this_user.contact.manager.budget_code, 
      :management_center => this_user.contact.manager.management_center, :work_order => this_user.contact.manager.work_order)
    super
  end

  #
  # This is needed in order to have active_scaffold handle
  # the actual creation
  def do_create
    if request.post?
      params[:record] = params[:order]
      super
    else
      @order = Order.new
    end
  end

  #
  # Order can only be deleted by the requestor
  # or one of the requestors managers
  def do_destroy
    @order = find_if_allowed(params[:id], :destroy)
    if @order.requestor==this_user or this_user.contact.manager_of?(@order.requestor.contact.id)
      self.successful = @order.destroy
    else
      flash[:warning]="Only the requestor or the requestor's managers can delete this order"
    end
  end

  #
  # Ajax responses
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

  def add_details
    return unless request.xhr?
    @item=params[:item].to_s
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
    

  def add_order_item
    return unless request.xhr?
    if params[:product].to_i == 0
      flash[:notice] = "You must select a product first!"
      render :update do |page|
        page['order-form-messages'].show
        page.replace_html 'order-form-messages', flash[:notice]
        flash[:notice] = nil
        page.visual_effect :fade, 'order-form-messages', :duration => 5
      end
    else
      @product=Product.find(params[:product])
      count = params[:count] || 1
      unit_price = params[:unit_price] || @product.latest_price
      @order_item=OrderItem.new(:product=>@product, :quantity => count, :unit_price => unit_price, 
                                :can_substitute => params[:can_substitute])
      render_js
    end
  end

  def add_find_product
    if request.post?
      @product=Product.find(:first,:conditions=>"part_number rlike '#{params[:model_number]}'")
      if @product.nil?
        flash[:notice] = 'Failed to find item'
        render :update do |page|
          page['subform-messages'].show
          page.replace_html 'subform-messages', flash[:notice]
          flash[:notice]=nil
          page.visual_effect :fade, 'subform-messages', :duration => 5
        end
      else
        @order_item=OrderItem.new(:product=>@product,:quantity=>1,:unit_price=>@product.latest_price)
        render_js
      end
    end
  end

end

