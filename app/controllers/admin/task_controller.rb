class Admin::TaskController < Admin::BaseController

  active_scaffold :task do |config|
    columns.add :full_name
    list.columns = [:full_name, :title, :description, :controller, :action, :url, :roles, :related_tasks]
    update.columns = create.columns =  [:parent, :title, :description, :hidden, :controller, :action, :url, :roles, :related_tasks]
    columns[:parent].form_ui = :select
    columns[:title].inplace_edit=true
    columns[:description].inplace_edit=true
    columns[:full_name].sort_by :method => 'full_name'
    columns[:roles].form_ui = :select
    columns[:hidden].form_ui = :checkbox
    list.per_page = 50
  end

end
