class Admin::ContactController < Admin::BaseController

  active_scaffold :contact do |config|
    list.columns = [:first_name, :last_name, :employer, :title, :department, :location, :phones, :email]
    update.columns = create.columns = [:first_name, :last_name, :employer, :employee_number, :title, :department, :phones,
      :location, :email, :location, :manager, :notes, :fund_code, :budget_code, :management_center, :work_order]
    columns.exclude :devices
    subform.columns = [:first_name, :last_name, :employer, :employee_number, :title, :department, :location, :phones, :email]
    columns[:location].form_ui = :select
  end

end
