class MaintenanceLog < ActiveRecord::Base

  before_create :set_user

  belongs_to :loggable, :polymorphic => true

  validates_presence_of :title
  
  def to_label
    "#{title}"
  end

  def set_user
    self.created_by = User.current_user.to_label
  end


end
