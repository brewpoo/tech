class Admin::WirelessOutputFilterController < Admin::BaseController

  active_scaffold :wireless_output_filter do |config|
    list.columns = [:title, :description, :output_filter, :is_active]
    create.columns = update.columns = [:title, :description, :output_filter, :is_active]
    columns[:is_active].form_ui = :checkbox
  end

end
