class Admin::ZoneController < Admin::BaseController

  active_scaffold :zone do |config|
    list.columns = create.columns = update.columns = [:parent, :name, :description]
    columns[:parent].form_ui = :select
  end

end
