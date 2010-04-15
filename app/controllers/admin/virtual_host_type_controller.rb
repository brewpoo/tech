class Admin::VirtualHostTypeController < ApplicationController
  
  active_scaffold :virtual_host_type do |config|
    list.columns = update.columns = create.columns = [:name, :description]
  end

end
