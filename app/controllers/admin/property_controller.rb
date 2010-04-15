class Admin::PropertyController < Admin::BaseController

  active_scaffold :property do |config|
    list.columns = create.columns = update.columns = [:name, :unit]
  end

end
