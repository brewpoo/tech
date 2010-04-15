#require_dependency "#{RAILS_ROOT}/vendor/plugins/acts_as_audited/lib/audit.rb"

class Audit < ActiveRecord::Base

  def to_label
    "#{action}(#{created_at})"
  end

end
