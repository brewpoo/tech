class DistributedItemController < ApplicationController

  before_filter :setup_active_scaffold

  active_scaffold :distributed_item do |config|
    actions.exclude :create, :update, :delete
    list.columns = [:distributed_on, :quantity, :order_item, :contact, :processor]
    list.sorting = {:distributed_on => :desc}
    columns[:contact].label = 'Picked Up By'
    columns[:order_item].search_sql = "order_items.details"
    columns[:contact].search_sql = "CONCAT(contacts.first_name,' ',contacts.last_name)"
    search.columns << [:order_item, :contact]
    # Filters
    config.actions.add :list_filter
    config.list_filter.add(:association, :processor, {:label => "Processor", :association => [ :processor] })
    config.list_filter.add(:associationmulti, :contact, {:label => "Picked Up By", :association => [ :contact] })
  end

  def setup_active_scaffold
      if current_user.has_role?('purchase_processor')
        active_scaffold_config.action_links.add('distribute',
                                              :label => 'Distribute Items',
                                              :type => :table,
                                              :crud_type => :create,
                                              :inline => false)
      else
        active_scaffold_config.actions.exclude('receipt')
      end
  end


  def distribute
    if request.post?
      redirect_to :action => 'distribute' and return if params[:distributed_item].blank?
      items = []
      notify = []
      DistributedItem.transaction do
        params[:distributed_item].each do |item|
          new_item=RequisitionItem.find(item[:id]).order_item.build_to_distributed_items(:quantity => item[:distribute_quantity],
                          :distributed_on => Time.now, :processor => User.current_user, :contact => Contact.find(params[:contact][:id]))
          new_item.save!
          items << new_item
          notify << new_item.order_item.order.requestor
        end
      end
      notify.uniq!
      notify.each do |requestor|
        notify_items = items.select {|item| item.order_item.order.requestor==requestor}
        Notifier.deliver_notify_distributed(requestor.contact, Contact.find(params[:contact][:id]),notify_items) unless Contact.find(params[:contact][:id]) == requestor.contact
      end
      flash[:notice]="Distributed"
      redirect_to  :action => 'list'
    else
      @contacts = Contact.company_contacts_select(this_user.contact.employer)
    end
  end

  def search
    render_flash("Please enter something to search for. e.g. PO number, Vendor, part number, etc.") and return if params[:q].blank?
    @items = []
    [Requisition,Order,Product,ProductFamily,Company,User].each do |klass| 
      klass.search(params[:q]).each do |result|
        @items << result.find_all_distributable_items
      end
    end
    @items.flatten!
    @items.uniq!
    @items.reject! {|item| !item.distributable? }
    if @items.length == 0
      render_flash("No results found")
    else
      render_js
    end
  end

  def add_item
    return unless request.xhr?
    @item = RequisitionItem.find(params[:id])
    if @item.number_distributable < params[:distribute_quantity].to_i
      render_flash("Cannot distribute more items than received")
    else
      @item.distribute_quantity = params[:distribute_quantity].to_i
      render_js
    end
  end

end
