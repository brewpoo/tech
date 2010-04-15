class RequisitionController < ApplicationController

  before_filter :setup_active_scaffold

  active_scaffold :requisition do |config|
    actions.exclude :create
    columns.add :orders, :total_cost, :order_items
    list.columns = [:created_on, :requisition_status, :release_number, :requisition_number, :purchase_order, 
                    :processor, :vendor, :total_cost, :orders]
    list.sorting = {:requisition_status => :asc}
    list.per_page = 50
    show.columns = [:requisition_status, :created_on, :due_by, :release_number, :awarded_on, :vendor, :requisitioned_on, 
                    :requisition_number, :purchased_on, :is_pcard_purchase, :purchase_order, :requisition_items, :total_cost, 
                    :processor, :orders, :notes, :budget_account, :management_center, :price_quote_number]
    update.columns = [:requisition_number, :purchase_order, :notes, :requisition_items]
    columns[:requisition_status].sort_by :sql => 'requisition_statuses.value'
    columns[:total_cost].sort_by :method => 'total_cost'
    columns[:is_pcard_purchase].form_ui = :checkbox
    columns[:is_pcard_purchase].label = "PCARD?"
    # Sorting and Searching
    columns[:requisition_items].includes = [:order_items]
    #columns[:order_items].includes = [:products]
    columns[:requisition_items].search_sql = "requisition_items.details"
    columns[:order_items].search_sql = "order_items.details"
    columns[:vendor].search_sql = "companies.name"
    #columns[:products].search_sql = "products.full_name"
    search.columns << [:requisition_items, :order_items, :vendor]
    # Filtering
    config.actions.add :list_filter
    config.list_filter.add(:association, :requisition_status, {:label => "Status", :association => [ :requisition_status ] })
    #config.list_filter.add(:association, :vendor, {:label => "Vendor", :association => [ :vendor ] })
    config.list_filter.add(:association, :processor, {:label => "Processor", :association => [ :processor ] })
  end

  def setup_active_scaffold
      if current_user.has_role?('purchase_processor')
        active_scaffold_config.action_links.add('request_bid',
                                              :label => 'Request Bids',
                                              :type => :record,
                                              :crud_type => :create,
                                              :inline => false)
      else
        active_scaffold_config.actions.exclude('request_bid')
      end
  end

  def pconditions_for_collection
    ['requisition_status < ?', Requisition::CLOSED ]
  end


  #
  # ActiveScaffold Method Overrides
  def edit
    #redirect_to :controller =>'user', :action => 'unauthorized' if !this_user.has_role?('purchase_processor')
    @requisition=Requisition.find(params[:id])
    #redirect_to :action => 'list'  and return if @requisition.requisition_status==RequisitionStatus.find_by_value(Requisition::CLOSED) 
    super
  end

  def update
    @requisition = Requisition.find(params[:id])
    if @requisition.update_attributes(params[:requisition])
      redirect_to :action => 'list'
    end
  end

  def request_bid
    @requisition = Requisition.find(params[:id])
    if request.post?
      @requisition.update_attributes(params[:requisition])
      purchase_contacts=[]
      params[:purchase_contact].each do |key, contact|
        @contact=Contact.find(key.to_i)
        if contact[:send_to].to_i == 1
          Notifier.deliver_request_bid(@contact, @requisition)
          purchase_contacts << @contact
        end
      end
      if purchase_contacts.length > 0
        Notifier.deliver_request_bid_sent(@requisition.processor.contact, @requisition, purchase_contacts) 
        @requisition.update_attribute(:sent_emails,true)
        flash[:info] = "Emails have been sent"
      end
      redirect_to :action => 'list'
    else
      @purchase_contacts=Contact.find_purchase_contacts
      @requisition.due_by = Time.today + 2.days + 10.hours
    end
  end

end
