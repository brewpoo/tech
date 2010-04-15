class PpLineController < ApplicationController

  active_scaffold :pp_line do |config|
    list.label = "Point-to-Point Lines"
    list.columns = [:map_reference, :circuit, :subnet]
    list.sorting = { :map_reference => :asc }
    list.per_page = 50
    nested.add_link('Circuit',[:circuit])
    create.columns = update.columns = [:map_reference, :circuit, :subnet, :notes]
    columns[:subnet].form_ui = :select
    columns[:circuit].association.reverse = :pp_line
    # Search and Sort
    columns[:circuit].sort_by :sql => 'circuits.circuit_number'
    columns[:circuit].search_sql = "circuits.circuit_number"
    columns[:subnet].search_sql = "subnets.description"
    columns[:subnet].sort_by :sql => 'subnets.description'
    search.columns << [:circuit, :subnet]
  end

end
