class Admin::ArchitectureController < Admin::BaseController

  active_scaffold :architecture do |config|
    list.columns = [:parent, :full_name, :description]
    update.columns = create.columns = [:parent, :name, :description]
    columns[:parent].form_ui = :select
  end

end
