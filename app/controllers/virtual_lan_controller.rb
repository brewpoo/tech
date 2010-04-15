class VirtualLanController < ApplicationController

  active_scaffold :virtual_lan do |config|
    show.columns = list.columns = [:vlanid, :name, :description, :subnets, :is_private]
    create.columns = update.columns = [:vlanid, :name, :description, :is_private]
    list.sorting = {:vlanid => :asc}
    list.per_page = 50
    columns[:is_private].form_ui =:checkbox
    columns[:is_private].label = 'Private?' 
  end

end
