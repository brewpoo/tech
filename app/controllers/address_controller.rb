class AddressController < ApplicationController

  active_scaffold :address do |config|
    subform.columns = [:street_address, :city, :state, :zip, :description]
  end

end
