class Admin::ProjectStatusController < Admin::BaseController

  active_scaffold :project_status do |config|
    list.columns = show.columns = create.columns = update.columns = [:name, :value]
  end

end
