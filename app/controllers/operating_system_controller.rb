class OperatingSystemController < ApplicationController

  active_scaffold :operating_system do |config|
    subform.columns = [:parent, :name]
    list.columns = [:long_name, :name]
    create.columns = update.columns = [:parent, :name, :description]
    show.columns = [:long_name, :children]
    columns[:parent].form_ui = :select
    list.per_page = 50
  end

end
