class Admin::DepartmentController < Admin::BaseController
  
  active_scaffold :department do |config|
    list.columns = [:company, :parent, :full_name, :name, :description, :alternate_name]
    update.columns = create.columns = [:company, :parent, :name, :alternate_name, :description]
    columns[:company].form_ui = :select
    columns[:parent].form_ui = :select
    columns[:name].inplace_edit=true
  end

end
