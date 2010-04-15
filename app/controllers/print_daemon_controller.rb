class PrintDaemonController < ApplicationController

  active_scaffold :print_daemon do |config|
    list.columns = show.columns = [:printer, :print_daemon_type, :server, :name]
    create.columns = update.columns = [:printer, :print_daemon_type, :server, :name]
    columns[:print_daemon_type].form_ui = :select
    columns[:server].form_ui = :select
    columns[:name].label = "Printer Name"
  end

end
