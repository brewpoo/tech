class Admin::PhoneController < Admin::BaseController

  active_scaffold :phone do |config|
    subform.columns = [:number, :phone_type, :description]
  end

end
