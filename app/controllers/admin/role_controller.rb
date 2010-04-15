class Admin::RoleController < Admin::BaseController
  
  active_scaffold :roles do |config|
    list.columns = [:name, :description]
    update.columns = create.columns = [:name, :flag, :description, :users]
  end

end
