class ApplicationServerController < ApplicationController

  active_scaffold :application_server do |config|
    show.columns = list.columns = [:application, :service, :service_status, :server]
    create.columns = update.columns = [:application, :server, :service, :service_status]
    #subform.columns = [:server, :service, :service_status]
    columns[:service].form_ui = :select
    columns[:service_status].form_ui = :select
  end

end
