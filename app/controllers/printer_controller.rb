class PrinterController < ApplicationController

  active_scaffold :printer do |config|
    columns.add :location
    list.columns = [:hostname, :description, :location, :print_daemons]
    create.columns = update.columns = [:hostname, :description, :print_daemons]
    show.columns = [:hostname, :description, :location, :print_daemons, :ipv4_interfaces, :equipment]
    list.sorting = {:hostname => :asc}
    list.per_page = 50
    columns[:equipment].association.reverse = :device
    nested.add_link("Print Daemons", [:print_daemons])
    nested.add_link("Equipment", [:equipment])
    # Sorting and Searching
    #columns[:printer_location].sort_by :sql => 'locations.long_name'
    #columns[:printer_location].search_sql = 'locations.long_name'
    #search.columns << [:printer_location]
    # Filters 
    #config.actions.add :list_filter
    #config.list_filter.add(:association, :primary_engineer, {:label => "Primary Engineer", :association => [:primary_engineer]})
  end

end
