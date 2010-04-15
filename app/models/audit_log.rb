class AuditLog < ActiveRecord::Base
  set_table_name "audits"
 
  belongs_to :user

end
