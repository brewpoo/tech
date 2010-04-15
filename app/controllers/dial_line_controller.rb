class DialLineController < ApplicationController

  active_scaffold :dial_line do |config|
    list.label = "Dial Lines"
    list.columns = [:device, :circuit, :phones]
    create.columns = update.columns = [:device, :circuit, :phones, :description]
    list.sorting = {:device => :asc}
    list.per_page = 50
    nested.add_link("Circuit",[:circuit])
    nested.add_link("Numbers",[:phones])
    # Searching and Sorting
    columns[:device].sort_by :sql => "devices.hostname"
    columns[:device].search_sql = "devices.hostname"
    columns[:circuit].sort_by :sql => "circuits.circuit_number"
    columns[:circuit].search_sql = "circuits.circuit_number"
    columns[:phones].sort_by :sql => "phones.number"
    columns[:phones].search_sql = "phones.number"
    search.columns << [:device, :circuit, :phones]
  end

end
