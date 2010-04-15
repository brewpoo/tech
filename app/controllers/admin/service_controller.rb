class Admin::ServiceController < ApplicationController

  active_scaffold :service do |config|
    list.columns = show.columns = [:name, :description]
    update.columns = create.columns = [:name, :description]
  end

end
