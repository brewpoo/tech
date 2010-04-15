class User < ActiveRecord::Base

  acts_as_reportable 

  belongs_to :contact
  has_and_belongs_to_many :roles 
  has_many :orders, :foreign_key => 'requestor_id'
  has_many :received_items, :foreign_key => 'receiver_id'
  has_many :distributed_items, :foreign_key => 'processor_id'
  has_many :requisitions, :foreign_key => 'processor_id'

  validates_presence_of :username

  cattr_accessor :current_user
  attr_accessor :default_task

  def has_role?(target)
    return false unless roles.detect{|role| role.flag == target}  
    return true
  end

  def match_any_roles?(roles)
    roles.each { |role|
      return true if has_role?(role.flag)
    }
    return false 
  end

  def to_label
    if contact
      contact.full_name
    else
      username
    end
  end

  def all_roles
    label=""
    roles.each do |role|
      label << ", " unless label.length == 0
      label << role.name
    end
    return label
  end

  def email
    contact.email
  end

  def User.login(username)
    User.find_by_username(username).update_attributes(:logged_in => true, :last_login => Time.now)
  end

  def User.logout(username)
    User.find_by_username(username).update_attributes(:logged_in => false)
  end

  def User.purchase_processor_select
    User.find(:all).select{|u| u.has_role?('purchase_processor')}.map{|u| [u.contact.last_first ,u.id]}
  end

  def User.session_sweeper
    expired_sessions = CGI::Session::ActiveRecordStore::Session.find(:all, :conditions => [ 'updated_at < ?', Time.now() - 2.hours ] )
    expired_sessions.each do |expired|
      who = Marshal.load(Base64.decode64(expired[:data]))
      User.logout(who[:user]) if who[:user]
      expired.destroy
    end
  end

  def User.search(q)
    contacts=Contact.find(:all,:conditions=>['last_name rlike ? or first_name rlike ?', q, q])
    User.find(:all).select { |user| contacts.include? user.contact }
  end

  def find_all_receiptable_items
    items=[]
    orders.each do |order|
      order.order_items.each do |order_item|
        order_item.requisition_items.each do |item|
          items << item if RequisitionItem.find_available_for_receipt.include? item
        end
      end
    end
    return items
  end

  def find_all_distributable_items
    items=[]
    orders.each do |order|
      order.order_items.each do |order_item|
        order_item.requisition_items.each do |item|
          items << item if RequisitionItem.find_available_for_distribution.include? item
        end
      end
    end
    return items
  end

  def self.set_contact_type
    Role.find_by_name('Network Engineer').users.each do |user|
      user.contact.update_attribute(:is_engineer,true)
    end
    Role.find_by_name('System Engineer').users.each do |user|
      user.contact.update_attribute(:is_engineer,true)
    end
   Role.find_by_name('Manager').users.each do |user|
      user.contact.update_attribute(:is_manager,true)
    end
  end

end
