class Admin::AuditController < Admin::BaseController

  active_scaffold :audit_log do |config|
    actions.exclude :create, :update, :delete
    list.columns = [:created_at, :user, :action, :auditable_type, :auditable_id, :changes, :version]
    list.sorting = {:created_at => :desc}
    list.per_page = 100
  end

end
