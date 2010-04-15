class ProjectType < ActiveRecord::Base

  acts_as_reportable

  has_many :projects

  def to_label
    "#{name} (#{abbreviation})"
  end

  def self.type_select
    ProjectType.find(:all).sort_by{|p| p.name}.map {|p| [p.to_label, p.id]}
  end

end
