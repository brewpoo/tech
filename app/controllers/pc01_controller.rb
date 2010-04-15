class Pc01Controller < ApplicationController

  active_scaffold :pc01 do |config|
    columns.add :budget_string
    list.columns = [:pc01_number, :created_on, :pc01_dated, :service_request, :orders, :department, :budget_string]
    show.columns = [:pc01_number, :created_on, :pc01_dated, :submitted_by,
      :service_request, :assigned_users, :department, :management_center, :budget_string, :location, :description, :notes, :pc01_items, :orders]
    create.columns = update.columns = [:pc01_dated, :submitted_by, 
      :service_request, :assigned_users, :department, :management_center, :location, :description, :notes, :pc01_items, :is_completed]
    list.sorting = {:pc01_number => :desc}
    list.per_page = 50
    columns[:approved_by].form_ui = :select
    columns[:location].form_ui = :select
    columns[:department].form_ui = :select
    columns[:submitted_by].form_ui = :select
    columns[:is_completed].label = "Completed?"
    columns[:is_completed].form_ui = :checkbox
    # Sorting and Searching
    columns[:notes].search_sql = "notes.body"
    columns[:pc01_items].search_sql = "pc01_items.description"
    # Filters
    config.actions.add :list_filter
    config.list_filter.add(:association, :department, {:label => "Department", :association => [ :department ] })
    # Other Stuff
    config.create.link.page = true
    config.update.link.page = true
    action_links.add('order',:label => 'Order Items', :type => :record, :crud_type => :create, :inline => false)
    action_links.add('charge_back',:label => 'Process Charge Backs', :type => :table, :crud_type => :create, :inline => false)
  end

  def pconditions_for_collection
    ['is_completed = 0 or is_completed is null']
  end

  #
  # ActiveScaffold overrides
  #

  #
  # Get's rid of ugly parameters in url
  def return_to_main
    redirect_to :action => 'list'
  end

  def order
    if request.post?
      @pc01=Pc01.find(params[:id])
      order_items=[]
      @orders=[]
      params[:order_items].each do |item|
        order_items <<  Pc01Item.find(item[1][:id]) if item[1][:selected]=='1'
      end unless params[:order_items].nil?
      order_items.group_by {|i| i.pc01_category.order_type}.each do |order_type, items|
        description = "Items:\n"
        items.each do |item|
          description += "#{item.to_label}\n"
        end
        if @pc01.management_center.include? "/"
          mc=@pc01.management_center.split('/')
          @pc01.update_attributes(:management_center => mc[1], :budget_code => mc[0])  
        end
        order=Order.create!(:service_request=>@pc01.service_request,:description=>"#{order_type.name} order for PC01 #{@pc01.pc01_number}",
                        :order_type => order_type, :requestor => this_user, :assignee => @pc01.assigned_users.split("\n").join(', '), 
                        :budget_year => @pc01.budget_year, :fund_code => @pc01.fund_code, :management_center => @pc01.management_center, 
                        :budget_code => @pc01.budget_code, :work_order => @pc01.work_order, :order_number => Order.next_order_number, :priority => 3,
                        :department => @pc01.department, :order_status => OrderStatus.find_by_value(Order::DRAFT), :ordered_on => Date.today.to_s,
                        :related_pc01 => @pc01.pc01_number, :pc01 => @pc01)
        order.create_in_notes(:body => description)
        items.each do |item|
          item.update_attribute(:is_replenished,true)
        end unless order.new_record?
        @orders << order
      end
      @count = order_items.length
      #redirect_to :action => 'order_completed' and return
      render :action => 'order_completed'
    else
      @pc01 = Pc01.find(params[:id])  
      @items = @pc01.pc01_items.select {|i| !i.is_stock_item and !i.is_replenished}
    end
  end
  
  def charge_back
    if request.post?
      # Process charge back items
      @charged_back_items=[]
      params[:charge_back_items].each do |id,item|
        next if item[:charge_back]=='0'
        pc01_item=Pc01Item.find(id)
        pc01_item.is_replenished = true
        pc01_item.replenished_on = Time.now
        pc01_item.charge_back_amount = item[:charge_back_amount].to_f
        pc01_item.save
        @charged_back_items << pc01_item
      end
      render :action => 'charge_back_completed'
    else
      @pc01_items = Pc01Item.find(:all).select {|i| !i.is_replenished and i.is_charge_back}
    end
  end

end
