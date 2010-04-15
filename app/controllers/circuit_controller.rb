class CircuitController < ApplicationController

  active_scaffold :circuit do |config|
    list.columns = [:provider, :circuit_number, :circuit_type, :line_type, :line_speed, :locations]
    create.columns = update.columns = [:provider, :circuit_number, :line_type, :line_speed, :locations, :date_installed,
      :description, :parent, :connected, :date_disconnected]
    subform.columns = [:circuit_number, :locations, :provider, :line_type, :line_speed]
    #columns[:locations].form_ui = :select
    columns[:provider].form_ui = :select
    columns[:circuit_type].form_ui = :select
    columns[:line_speed].form_ui = :select
    columns[:line_type].form_ui = :select
    columns[:parent].form_ui = :select
    columns[:connected].form_ui = :select
    #columns[:locations].form_ui = :select
    list.sorting = {:circuit_number => :asc}
    list.per_page = 50
    # Search and Sort
    columns[:locations].search_sql = "locations.long_name"
    search.columns << [:locations]
    # Filtering
    config.actions.add :list_filter
    config.list_filter.add(:association, :provider, {:label => "Provider", :association => [:provider]})
    config.list_filter.add(:association, :circuit_type, {:label => "Circuit Type", :association => [:circuit_type]})
    config.list_filter.add(:association, :line_type, {:label => "Line Type", :association => [:line_type]})
    config.list_filter.add(:association, :line_speed, {:label => "Line Speed", :association => [:line_speed]})
  end

end
