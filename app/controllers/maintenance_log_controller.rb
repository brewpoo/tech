class MaintenanceLogController < ApplicationController
  
  active_scaffold :maintenance_log do |config|
    list.columns = [:created_on, :title, :created_by]
    create.columns = update.columns = [:title, :body]
    show.columns = [:created_on, :updated_on, :created_by, :title, :body]
    list.per_page = 50
    list.sorting = {:created_on => :desc}
  end
end
