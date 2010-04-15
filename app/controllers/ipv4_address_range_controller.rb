class Ipv4AddressRangeController < ApplicationController

  active_scaffold :ipv4_address_range do |config|
    subform.columns = [:start_address, :end_address, :is_dynamic]
    columns[:is_dynamic].form_ui = :checkbox
    columns[:is_dynamic].label = "Dynamic?"
  end

end
