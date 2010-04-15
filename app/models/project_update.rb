class ProjectUpdate < ActiveRecord::Base
  
  acts_as_reportable

  before_save :set_user

  belongs_to :project

  def set_user
    self.created_by = User.current_user.to_label
  end

end
