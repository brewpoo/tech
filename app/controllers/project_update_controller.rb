class ProjectUpdateController < ApplicationController

  active_scaffold :project_update do |config|
    create.columns = update.columns = [:body]
    list.columns = [:created_on, :created_by, :body]
    show.columns = [:created_on, :updated_on, :created_by, :body]
    list.sorting = {:created_on => :desc}


  end

end
