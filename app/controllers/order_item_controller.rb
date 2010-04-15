class OrderItemController < ApplicationController

  active_scaffold :order_item do |config|
    columns.add :manufacturer
    subform.columns = list.columns = [:manufacturer, :product, :quantity, :unit_price]
    columns[:manufacturer].form_ui = :select
  end

end
