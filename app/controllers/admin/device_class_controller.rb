class Admin::DeviceClassController < Admin::BaseController

  active_scaffold :device_class do |config|
    show.columns = list.columns = [:parent, :full_name, :name, :set_type, :description]
    update.columns = create.columns = [:parent, :name, :set_type, :description]
    columns[:parent].form_ui = :select
  end

end
