class Contact < ActiveRecord::Base

  gem 'validates_email'
  require 'validates_email'

  acts_as_reportable
  belongs_to :employer,
    :class_name => 'Company',
    :foreign_key => 'employer_id'
  belongs_to :department
  belongs_to :location
  belongs_to :manager,
    :class_name => "Contact",
    :foreign_key => "manager_id"
  has_many :subordinates, :class_name => "Contact", :foreign_key => "manager_id"
  has_many :devices
  has_many :wireless_interfaces
  has_many :phones, :as => :phonable, :dependent => :destroy
  has_many :notes, :as => :notable, :dependent => :destroy
  has_many :locations
  has_many :companies
  has_one :user
  has_many :distributed_items
  has_many :orders, :foreign_key => 'manager_id'#, :conditions => 'contacts.is_manager=1'
  has_many :requested_projects, :class_name => "Project", :foreign_key => 'requestor_id'
  has_many :managed_projects, :class_name => "Project", :foreign_key => 'manager_id'
  has_many :lead_engineer_projects, :class_name => "Project", :foreign_key => 'lead_engineer_id'

  has_and_belongs_to_many :projects, :join_table => "engineers_projects", :foreign_key => "engineer_id"

  validates_presence_of :last_name
  validates_presence_of :first_name

  validates_format_of :email, :with => %r{^(?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4})$}i, :allow_nil => true

  validates_presence_of :employer, :if => Proc.new { |contact| contact.is_purchase_contact? }
  validates_uniqueness_of :first_name, :scope => :last_name
  validates_uniqueness_of :employee_number, :scope => :employer_id, :allow_nil => true

  before_save :set_is_manager

  attr_accessor :send_to

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def to_label
    label=full_name
    label = label + " / " + self.department.name if self.department
    label = label + " / " + self.employer.name if self.employer
    return label
  end

  def all_phones
    label=""
    phones.each do |phone|
      label << ", " unless label.length == 0
      label << "#{phone.phone_type.phone_type} #{phone.number}"
    end
    return label
  end

  def last_first
    "#{last_name}, #{first_name}"
  end

  def last_first_label
    label=last_first
    label = label + " / " + self.department.name if self.department
    label = label + " / " + self.employer.name if self.employer
    return label
  end

  def used
    total = self.devices.length + self.distributed_items.length + self.wireless_interfaces.length + self.orders.length
    return total
  end

  def manager_of?(target)
    this=Contact.find(target)
    while !this.manager.nil?
      return false if this.manager.nil?
      return true if this.manager == self
      this=this.manager
    end
    return false
  end

  def employee_of?(target)
    here=self
    boss=Contact.find(target)
    while !here.manager.nil?
      return false if here.manager.nil?
      return true if boss == here.manager
      here = here.manager
    end
    return false
  end

  def manager_name
    manager.to_label if manager
  end

  def manager_select
    here=self
    managers=[]
    while !here.manager.nil?
      managers << here.manager
      here = here.manager
    end
    managers.map {|m| [m.to_label, m.id]}
  end

  def Contact.contact_managers_select
    Contact.find(:all).select{|c| c.subordinates}.sort_by{|c| c.last_name}.map {|m| [m.to_label, m.id] }
  end

  def find_subordinates
    Contact.find(:all).select{|c| self.manager_of? c}
  end

  def Contact.find_purchase_contacts
    Contact.find(:all, :conditions => 'is_purchase_contact=1').sort_by { |c| c.employer.name if c.employer }
  end

  def Contact.company_contacts_select(employer)
    employer.contacts.sort_by{ |c| c.last_name}.map {|c| [c.last_first, c.id]}
  end

  def Contact.all_contacts
      Contact.find(:all, :order => "last_name asc, first_name asc").map { |m| [m.last_first_label, m.id] }
  end

  def Contact.select
  # Return select map data from Contact.all_contacts
  # First tries to read from cache
    all_contacts = CACHE.get("all_contacts")
    if all_contacts==nil
      Contact.run_precache
      all_contacts = CACHE.get("all_contacts")
    end
    return all_contacts
  rescue 
    return Contact.all_contacts
  end

  def used?
    return false unless devices || orders || locations || wireless_interfaces
    return true
  end

  def Contact.used_contacts
    Contact.find(:all).select{|c| c.used?}.sort_by{|c|[c.last_name, c.first_name]}.map{|c| ["#{c.last_first_label}", c.id]}
  end


  def Contact.used_select
  # Return select map data from Contact.used_contacts
  # First tries to read from cache
    used_contacts = CACHE.get("used_contacts")
    if used_contacts == nil
      Contact.run_precache
      used_contacts = CACHE.get("used_contacts")
    end
    return used_contacts
  rescue
    return Contact.used_contacts
  end

  def self.run_precache
    CACHE.set("used_contacts",Contact.used_contacts)
    CACHE.set("all_contacts",Contact.all_contacts)
  end

  def set_is_manager
    #self.is_manager = self.subordinates
  end

end
