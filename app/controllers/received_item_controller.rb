class ReceivedItemController < ApplicationController

  before_filter :setup_active_scaffold

  active_scaffold :received_item do |config|
    actions.exclude :create, :update, :delete
    columns.add :purchase_order, :assigned_user, :release_number #, :order_item, :product
    list.columns = [:received_on, :quantity, :requisition_item, :purchase_order, :release_number, :assigned_user, :receiver]
    list.sorting = {:received_on => :desc} 
    # Sorting and Searching
    columns[:purchase_order].sort_by :method => 'purchase_order'
    columns[:assigned_user].sort_by  :method => 'assigned_user'
    columns[:release_number].sort_by :method => 'release_number'
    #search.columns << [:release_number, :purchase_order]
    # Filters
    config.actions.add :list_filter
    config.list_filter.add(:association, :receiver, {:label => "Receiver", :association => [ :receiver] })
  end

  def setup_active_scaffold
      if current_user.has_role?('purchase_processor')
        active_scaffold_config.action_links.add('receipt',
                                              :label => 'Receive Items',
                                              :type => :table,
                                              :crud_type => :create,
                                              :inline => false)
      else
        active_scaffold_config.actions.exclude('receipt')
      end
  end


  def receipt
    if request.post?
      items = []
      notify = []
      ReceivedItem.transaction do 
        params[:received_item].each do |item|
          requisition_item=RequisitionItem.find(item[:id])
          new_item=requisition_item.build_to_received_items(:quantity => item[:receive_quantity],
              :received_on => Time.now, :receiver => User.current_user)
          new_item.save!
          items << new_item
          notify << new_item.requisition_item.order_item.order.requestor
        end
      end
      notify.uniq!
      notify.each do |requestor|
        notify_items = items.select {|item| item.requisition_item.order_item.order.requestor==requestor}
        Notifier.deliver_notify_received(requestor.contact, notify_items) unless User.current_user == requestor
      end
      flash[:notice]="Receipt Added"
      redirect_to :action => 'list'
    end
  end

  def search
    render_flash "Please enter something to search for. e.g. PO number, Vendor, part number, etc." and return if params[:q].blank?
    @items = []
    [Requisition,Order,Product,ProductFamily,Company,User].each do |klass|
      klass.search(params[:q]).each do |result|
        @items << result.find_all_receiptable_items
     end
    end
    @items.flatten!
    @items.uniq!
    @items.reject! {|item| !item.receivable? }
    if @items.length == 0
      render_flash "No results found"
    else
      render_js
    end
  end

  def add_item
    return unless request.xhr?
    @item = RequisitionItem.find(params[:id])
    if @item.number_receivable < params[:receive_quantity].to_i
      render_flash "Cannot receive more items than purchased"
    else
      @item.receive_quantity = params[:receive_quantity].to_i
      render_js
    end
  end

end
