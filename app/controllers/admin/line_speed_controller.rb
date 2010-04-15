class Admin::LineSpeedController < Admin::BaseController

  active_scaffold :line_speed do |config|
    create.columns = update.columns = list.columns = [:parent, :name, :speed]
  end

end
