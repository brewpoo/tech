class Admin::AddressController < Admin::BaseController

  active_scaffold :address do |config|
    list.columns=[:street_address, :city, :state, :description, :location]
    subform.columns = create.columns = update.columns = [:street_address, :city, :state, :zip, :description, :location]
  end

end
