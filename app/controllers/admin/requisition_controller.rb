class Admin::RequisitionController < Admin::BaseController

  active_scaffold :requisition do |config|
    actions.exclude :create
    columns.add :orders, :total_cost, :order_items
    list.columns = [:created_on, :requisition_status, :due_by, :release_number, :requisition_number, :purchase_order,
                    :processor, :vendor, :total_cost, :orders]
    list.sorting = {:requisition_status => :asc}
    list.per_page = 50
    show.columns = [:requisition_status, :created_on, :due_by, :release_number, :awarded_on, :vendor, :requisitioned_on, :requisition_number,
                    :purchased_on, :purchase_order,
                    :requisition_items, :total_cost, :processor, :orders, :notes, :budget_account, :management_center, :price_quote_number]
    update.columns = [:requisition_status, :release_number, :processor, :vendor, :requisition_number, :purchase_order, :notes, :requisition_items, 
      :budget_account, :management_center, :price_quote_number]
    columns[:requisition_status].sort_by :sql => 'requisition_statuses.value'
    columns[:total_cost].sort_by :method => 'total_cost'
    columns[:processor].form_ui = :select
    config.update.link.page = true
  end

end
