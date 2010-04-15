class Pc01CategoryController < ApplicationController

  active_scaffold :pc01_category do |config|
    show.columns = list.columns = update.columns = create.columns = [:title, :description, :order_type]
    columns[:order_type].form_ui = :select
  end

end
