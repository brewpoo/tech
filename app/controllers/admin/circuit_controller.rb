class Admin::CircuitController < Admin::BaseController

  active_scaffold :circuit do |config|
    columns.exclude :children
    list.columns = [:circuit_number, :provider, :circuit_type, :line_speed, :locations, :description]
    create.columns = update.columns = [:parent, :circuit_number, :provider, :circuit_type,
      :line_speed, :locations, :description, :date_installed]
    columns[:provider].form_ui = :select
    columns[:line_speed].form_ui = :select
    columns[:circuit_type].form_ui = :select
    columns[:parent].form_ui = :select
    columns[:date_installed].form_ui = :calendar
  end

end
