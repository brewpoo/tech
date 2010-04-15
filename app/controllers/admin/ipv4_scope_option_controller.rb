class Admin::Ipv4ScopeOptionController < Admin::BaseController

  active_scaffold :ipv4_scope_option do |config|
    list.columns = update.columns = create.columns = [:name, :description, :value]
  end

end
