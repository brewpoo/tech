class Note < ActiveRecord::Base

  belongs_to :notable, :polymorphic => true
  validates_presence_of :body

  before_create :set_user

  attr_accessor :should_destroy

  def should_destroy?
    should_destroy.to_i == 1
  end

  def to_label
    "#{body}"
  end

  def set_user
    self.created_by = User.current_user.to_label
  end

end
