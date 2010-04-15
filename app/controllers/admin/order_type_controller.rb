class Admin::OrderTypeController < Admin::BaseController

  active_scaffold :order_type do |config|
    columns[:processor].form_ui = :select
  end

end
