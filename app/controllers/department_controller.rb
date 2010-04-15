class DepartmentController < ApplicationController

  active_scaffold :department do |config|
    subform.columns = [:name]
  end

end
