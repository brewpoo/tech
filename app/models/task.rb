class Task < ActiveRecord::Base
  include TreeFunctions

  acts_as_tree :order => 'title'
  has_and_belongs_to_many :roles
  has_many :related_tasks

  validates_uniqueness_of :action, :scope => 'controller', :allow_nil => true

  def name
    title
  end

  def to_label
    full_name
  end

  def last?
    return true if self == Task.find(:first, :conditions => ["parent_id IS NULL"], :order => 'title desc')
  end

  def empty?
    return true if controller.nil?
    return false
  end

  def link
    return url if url?
    return "#{controller}/#{action}"
  end

  def visible
    !hidden
  end

  def inherited_roles
    return roles if !roles.empty?
    if parent
      return parent.inherited_roles
    else
      return false
    end
  end

  def has_visible_children?
    return true if children.detect {|c| !c.hidden}
    return false
  end

end
