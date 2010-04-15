# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  include ExceptionNotification::Notifiable


  audit Address, App, ApplicationServer, Architecture, Circuit, CircuitType, Company, Component,
  Contact, Department, DeviceClass, Device, DialLine, DistributedItem, 
  Domain, Equipment, EquipmentStatus, Interface, Ipv4Assignment, Ipv4Interface,
  Ipv4SchemaRule, Ipv4Scope, Ipv4Subnet, Ipv4VirtualHost,
  LineSpeed, Location, MpLine, MpDlci, MpPvc, NetworkClass, Note, OperatingSystem, Order, OrderItem, Pc01, Pc01Category, Pc01Item, Phone, PhoneType, 
  PpLine, PrintDaemon, ProductFamily, Product, Project, ProjectUpdate, Requisition, RequisitionItem, ReceivedItem, Role, Service, State, Subnet, 
  Task, Topology, User, WirelessInterface, Zone, :only => [:create, :update, :destroy] if ENV['RAILS_ENV']=='production'

  before_filter :authenticated?, :except => [:login, :remote_approve, :load_balance_test]
  before_filter :authorized?, :except => [:login, :remote_approve, :load_balance_test]

  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_tech_session_id'

  filter_parameter_logging :password
  filter_parameter_logging :data

  public 

  #def rescue_action(exception)
  #  case(exception)
  #    when ActiveRecord::RecordNotFound
  #      redirect_to :controller => 'user', :action => 'record_not_found'
  #    when ActionController::RoutingError
  #      redirect_to :controller => 'user', :action => 'routing_error'
  #    else redirect_to :controller => 'user', :action => 'error', :error => exception
  #  end
  #end

  def this_user
    @user ||= User.find_by_username(session[:user])
  end
  helper_method :this_user

  def logged_in?
    !session[:user].nil?
  end
  helper_method :logged_in?

  def initialize_ldap
    conn = {:host => $settings[:ldap_host], :port => $settings[:ldap_port]}
    conn[:base] = $settings[:ldap_base]
    conn[:encryption]= {:method => :simple_tls} if $settings[:ldap_ssl]
    Net::LDAP.new( conn )
  end

  def get_dn(username)
    ldap = initialize_ldap
    filter = Net::LDAP::Filter.eq('objectClass','inetOrgPerson') & Net::LDAP::Filter.eq('cn',username)
    ldap.search(:filter => filter, :return_result => false) do |entry|
      return entry.dn
    end
  end

  def ldap_get(username,target)
    ldap = initialize_ldap
    filter = Net::LDAP::Filter.eq('objectClass','inetOrgPerson') & Net::LDAP::Filter.eq('cn',username)
    ldap.search(:filter => filter, :attributes => target) do |entry|
      entry.send(target).each { |k| return k }
    end
  end

  def check_group(dn)
    ldap = initialize_ldap
    filter = Net::LDAP::Filter.eq('objectClass','groupOfNames')
    ldap.search(:base => $settings[:ldap_group], :filter => filter, :attributes => ['member'], :scope => Net::LDAP::SearchScope_BaseObject) do |entry|
      entry.member.each { |member| return true if (member==dn) }
    end
    return false
  end

  def update_user(username)
    user=User.find_by_username(username) || User.new
    user.last_login = Time.now
    user.dn = get_dn(username)
    if user.new_record?
      user.username = username
      user.roles=[Role.find_by_flag('application_user')]
    end
    contact = user.contact || user.build_contact
    contact.last_name = ldap_get(username,'sn')
    contact.first_name = ldap_get(username,'givenName')
    contact.title = ldap_get(username,'title')
    contact.employee_number = ldap_get(username, 'employeeID')
    contact.email = ldap_get(username, 'mail').downcase
    contact.employer = Company.find(:first)
  end

  def tree_select_map(list,indent)
    output = []
    margin = ""
    indent.times { margin += "--" }
    list.each { |item|
      output.push [margin+item.name, item.id]
      if !item.children.empty?
        output.concat tree_select_map(item.children,indent+1)
      end
    }
    return output
  end

  helper_method :tree_select_map

  def render_flash(message,div='messages')
    flash[:notice]=message
    render :update do |page|
      page.replace_html div, flash[:notice]
      flash[:notice] = nil
      page.visual_effect :fade, div, :duration => 5
    end
  end

  def render_js
    respond_to do |wants|
      wants.js
    end
  end

  def return_back(message=nil)
    flash[:notice]=message
    redirect_to :back
  end

  protected

    def current_user
      @user ||= User.find_by_username(session[:user])
    end

    def authenticated?
      unless session[:user]
        session[:requested_action] = action_name
        session[:requested_controller] = controller_path
        session[:requested_id] = params[:id]
        respond_to do |format|
          format.html { redirect_to :controller => '/user', :action => 'login' }
          format.js { render :update  do |page| page.redirect_to(:controller => '/user', :action => 'login') end}
        end
        return false
      end
      User.current_user = User.find_by_username(session[:user])
      return true
    end

    def authorized?
      task=Task.find(:first,:conditions=>['action=? and controller=?',action_name,'/'+controller_path]) || 
           Task.find(:first,:conditions=>['controller=?','/'+controller_path]) 
           Task.new
      return true if task.nil? or this_user.match_any_roles?(task.inherited_roles) 
      redirect_to :controller => '/user', :action => 'unauthorized' unless request.xhr?
      render_flash('You are unauthorized to perform this action') if request.xhr?
      false
    end

end
