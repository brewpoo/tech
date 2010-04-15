class Admin::TopologyController < Admin::BaseController
  
  active_scaffold :topology do |config|
    columns.exclude :interfaces, :subnets, :children
    list.columns = [:parent, :full_name, :name, :description]
    create.columns = update.columns = [:parent, :name, :description]
    columns[:parent].form_ui = :select
  end

end
