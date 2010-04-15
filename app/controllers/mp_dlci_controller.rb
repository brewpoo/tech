class MpDlciController < ApplicationController

  active_scaffold :mp_dlci do |config|
    list.label = "Multi-Point Device Interface Mappings"
    list.columns = update.columns = create.columns = [:dlci, :mp_line, :interface]
    list.per_page = 50
    columns[:interface].form_ui = :select
    columns[:mp_line].form_ui = :select
  end

end
