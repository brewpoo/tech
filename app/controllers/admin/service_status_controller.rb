class Admin::ServiceStatusController < ApplicationController

  active_scaffold :service_status do |config|
    list.columns = [:name, :description]
    create.columns = update.columns = show.columns = [:name, :description, :value]
  end
    
end
