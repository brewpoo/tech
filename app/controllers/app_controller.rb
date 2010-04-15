class AppController < ApplicationController

  active_scaffold :app do |config|
    list.columns = subform.columns = [:name, :short_name, :department, :priority, :manager]
    show.columns = create.columns = update.columns = [:name, :description, :short_name, :department, :priority, :owner, :manager]
    list.label = "Applications"
    list.per_page = 50
    list.sorting = {:name => :asc}
    columns[:department].form_ui = :select
    columns[:owner].form_ui = :select
    columns[:manager].form_ui = :select
    columns[:priority].form_ui = :select
    nested.add_link("Servers", [:application_servers])
    # Filters
    config.actions.add :list_filter
    config.list_filter.add(:association, :department, {:label => "Department", :association => [:department]})
    config.list_filter.add(:association, :manager, {:label => "Manager", :association => [:manager]})
  end

end
