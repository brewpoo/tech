class RequisitionItemController < ApplicationController

  active_scaffold :requisition_item do |config|
    actions.exclude :create, :delete 
    subform.columns = [:quantity]
  end

end
