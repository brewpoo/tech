class Admin::StateController < Admin::BaseController
  
  active_scaffold :state do |config|
    list.columns = [:name,:abbr]
    create.columns = update.columns = [:name,:abbr]
  end

end
