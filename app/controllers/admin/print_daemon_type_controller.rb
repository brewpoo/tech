class Admin::PrintDaemonTypeController < ApplicationController

  active_scaffold :print_daemon_type do |config|
    create.columns = update.columns = show.columns = list.columns = [:name, :description]
  end

end
