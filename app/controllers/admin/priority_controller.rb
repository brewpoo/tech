class Admin::PriorityController < Admin::BaseController

  active_scaffold :priority do |config|
    list.columns = show.columns = create.columns = update.columns = [:name, :value]
  end

end
