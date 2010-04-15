class Admin::OrderController < Admin::BaseController

  active_scaffold :order do |config|
    actions.exclude :create
    columns.add :total_cost, :requisitions
    list.columns = [:order_number, :ordered_on, :order_type, :project, :description, :requestor,
          :total_cost, :order_status, :requisitions]
    list.sorting = {:order_status => :asc}
    list.per_page = 50
    update.columns = [:order_number, :order_type, :requestor, :order_status, :description, :project, :justification, :department, :management_center,
      :department_control_number, :assignee, :related_pc01, :hw, :hwdl, :priority, :notes, :order_items]
    columns[:ordered_on].label = 'Date Ordered'
    columns[:total_cost].label = 'Estimate Cost'
    columns[:order_status].sort_by :sql => 'order_statuses.value'
    columns[:total_cost].sort_by :method => 'total_cost'
    columns[:order_type].form_ui = :select
    columns[:requestor].form_ui = :select
    show.columns = [:order_number, :ordered_on, :requestor, :order_type, :priority, :order_status_title, :approved_by, :approved_on,
         :description, :project, :justification, :department, :assignee, :department_control_number, :related_pc01, :order_items, :total_cost, :notes]
    config.update.link.page = true
  end


end
