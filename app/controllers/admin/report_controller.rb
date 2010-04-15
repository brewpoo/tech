class Admin::ReportController < Admin::BaseController

  active_scaffold :report do |config|
    list.columns = [:title, :description, :model, :controller, :action]
    create.columns = update.columns = show.columns = [:title, :description, :model, :controller, :action, :filters]
  end

end
