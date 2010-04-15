class Admin::PhoneTypeController < Admin::BaseController

  active_scaffold :phone_type do |config|
    list.columns = create.columns = update.columns = [:phone_type]
  end

end
