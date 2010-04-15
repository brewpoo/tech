class Project < ActiveRecord::Base

  acts_as_reportable

  before_create :set_user

  belongs_to :requestor,
    :class_name => "Contact",
    :foreign_key => "requestor_id"

  belongs_to :manager,
    :class_name => "Contact",
    :foreign_key => "manager_id",
    :conditions => "contacts.is_manager = 1"

  belongs_to :lead_engineer,
    :class_name => "Contact",
    :foreign_key => "lead_engineer_id",
    :conditions => "contacts.is_engineer = 1"
  
  belongs_to :department
  has_many :orders

  has_many :attachments, :as => :attachable
  has_many :links, :as => :linkable
  has_many :project_updates, :dependent => :destroy
  
  belongs_to :priority
  belongs_to :project_status
  belongs_to :project_type
  validates_presence_of :project_type
  validates_associated :project_type

  has_and_belongs_to_many :engineers, :join_table => "engineers_projects", :class_name => "Contact",
    :association_foreign_key => "engineer_id", :conditions => "contacts.is_engineer = 1"

  validates_presence_of :project_number
  #validates_format_of :project_number, :with => /[A-Z]?[0-9]+/, :message  => "is invalid, must be like AA000 (i.e. PN10)"
  validates_uniqueness_of :project_number, :scope => 'project_type_id'

  validates_presence_of :title

  INITIAL = 0
  WORKING = 1
  PENDING = 2
  COMPLETE = 3

  def project_type_and_number
    return project_number if project_type.nil?
    "#{project_type.abbreviation}#{project_number}"
  end

  def latest_update
    return nil unless project_updates
    latest = project_updates.last
    return "On #{latest.created_on} by #{latest.created_by}: #{latest.body}"
  end

  def project_status_title
    case project_status
      when INITIAL
        'Not Started'
      when WORKING
        'In-Progress'
      when PENDING
        'Pending'
      when COMPLETE
        'Complete'
    end
  end

  def project_priority_title
    case priority
      when 1
        'Low'
      when 3
        'Medium'
      when 5
        'High'
    end
  end

  def to_label
    return "#{project_type_and_number} - #{title}" unless project_number.blank?
    return title
  end

  #def numeric_project_number
  #  value=/\d+/.match(project_number)
  #  return value[0].to_i unless value == nil
  #  return 0
  #end

  #def alpha_project_number
  #  value=/\D+/.match(project_number)
  #  return value[0] unless value == nil
  #  return "_"
  #end

  def is_active?
    return false if project_status.nil?
    return true unless project_status.value>2
  end

  def total_spent
    return "n/a" unless orders
    cost = 0.0
    orders.each do |o|
      cost += o.total_spent
    end
    return cost
  end
    
  
  def Project.select_map
    Project.find(:all).select{|p| p.is_active?}.sort_by{|p| [p.project_type.name,p.project_number]}.map {|p| ["#{p.project_type_and_number} - #{p.title}", p.id]}
  end

  def self.next_project_number(type)
    if Project.count(:conditions => ["project_type_id=?",type]) > 0
      return Project.maximum(:project_number,:conditions=>["project_type_id=?",type]).to_i+1
    else
      return 1
    end
  end

  def set_user
    self.created_by = User.current_user.to_label
  end


end
