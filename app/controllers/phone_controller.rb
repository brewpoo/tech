class PhoneController < ApplicationController

  active_scaffold :phone do |config|
    list.columns = subform.columns = [:number, :phone_type, :description]
  end

end
