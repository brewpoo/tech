class Pc01ItemController < ApplicationController

  active_scaffold :pc01_item do |config|
    subform.columns = [:quantity, :pc01_category, :description, :is_charge_back, :is_stock_item, :is_true_up]
    columns[:is_stock_item].form_ui = :checkbox
    columns[:is_stock_item].label = "Stock Item?"
    columns[:is_charge_back].form_ui = :checkbox
    columns[:is_charge_back].label = "Charge Back?"
    columns[:is_true_up].form_ui = :checkbox
    columns[:is_true_up].label = "True Up?"

  end

end
