class Admin::CircuitTypeController < Admin::BaseController
  
  active_scaffold :circuit_type do |config|
    list.columns = [:name, :description]
    update.columns = create.columns = show.columns = [:name, :description, :flag]
  end

end
