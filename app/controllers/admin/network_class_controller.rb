class Admin::NetworkClassController < Admin::BaseController

  active_scaffold :network_class do |config|
    list.columns = [:parent, :full_name, :name, :description]
    update.columns = create.columns = [:parent, :name, :description]
    columns[:parent].form_ui = :select
  end

end
