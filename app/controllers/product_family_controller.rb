class ProductFamilyController < ApplicationController

  active_scaffold :product_family do |config|
    subform.columns = [:manufacturer, :name]
  end

end
