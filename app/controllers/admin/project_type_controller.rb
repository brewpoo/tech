class Admin::ProjectTypeController < Admin::BaseController

  active_scaffold :project_type do |config|
    list.columns = show.columns = create.columns = update.columns = [:name, :description, :abbreviation]
  end

end
