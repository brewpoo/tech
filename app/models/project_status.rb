class ProjectStatus < ActiveRecord::Base

  acts_as_reportable

  has_many :projects

  def to_label
    name
  end

end
