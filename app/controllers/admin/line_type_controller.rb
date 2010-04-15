class Admin::LineTypeController < ApplicationController

  active_scaffold :line_type do |config|
    list.columns = [:parent, :full_name, :name]
    update.columns = create.columns = [:parent, :name, :description]
    columns[:parent].form_ui = :select
  end

end
