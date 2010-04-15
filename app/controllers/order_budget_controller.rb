class OrderBudgetController < ApplicationController

  active_scaffold :orders do |config|
    list.label = "Order Budget Information"
    actions.exclude :create, :delete
    columns.add :project_short, :total_cost, :requisitions, :products, :budget_string
    list.columns = [:order_number, :ordered_on, :order_type, :project_short, :description, :requestor,
      :order_status, :total_cost, :budget_year, :budget_string]
    update.columns = [:manager, :project, :budget_year, :fund_code, :budget_code, :management_center, :work_order]
    list.sorting = {:ordered_on => :desc}
    list.per_page = 50
    columns[:ordered_on].label = 'Date Ordered'
    columns[:total_cost].label = 'Estimate Cost'
    columns[:project_short].label = 'Project'
    columns[:manager].form_ui = :select
    columns[:project].form_ui = :select
    # Searching and Sorting
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
    search.columns << [:order_type, :project_short, :project, :order_items, :products]
    # Other Stuff
    show.columns = [:order_number, :ordered_on, :requestor, :order_type, :priority, :order_status, :approved_by, :approved_on,
      :description, :project, :justification, :department, :assignee, :budget_year, :budget_string, :service_request, :department_control_number,
      :related_pc01, :order_items, :total_cost, :notes, :closed_on]
  end

end
