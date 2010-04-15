class UserController < ApplicationController
  #layout nil, :only => :load_balance_test
  include SslRequirement
  ssl_required :login if ENV['RAILS_ENV']=='production'

  def index
  end

  def unauthorized
  end

  def flush
    expire_fragment(:controller => "task", :action => "menu", :user_id => this_user.id)
  end

  def login
    if request.post? 
      if authenticate(params[:username], params[:password]) then
        session[:user]=params[:username]
        User.login(session[:user])
        if session[:requested_controller].nil? and !this_user.default_controller.blank?
          redirect_to :action => this_user.default_action,
                      :controller => this_user.default_controller
          return
        else 
          if session[:requested_id]
          redirect_to :action => session[:requested_action],
                      :controller => session[:requested_controller],
                      :id => session[:requested_id]
          else
          redirect_to :action => session[:requested_action],
                      :controller => session[:requested_controller]
          end
          return
        end
        redirect_to :action => 'home' and return
      else
        redirect_to :action => 'login' and return 
      end
    end
  end

  def logout
    User.logout(session[:user])
    session[:user]=nil
    redirect_to :action => 'login'
  end

  def account
    @user=User.find(this_user.id)
    @task=Task.find(:first,:conditions=>['action=? and controller=?',@user.default_action,'/'+@user.default_controller]) ||
          Task.find(:first,:conditions=>['controller=?','/'+@user.default_controller]) || Task.new
  end

  def record_not_found
  end

  def set_default
    return unless request.xhr?
    task=Task.find(params[:user][:default_task])
    @user=User.find(this_user.id)
    @user.update_attributes(:default_action => task.action, :default_controller => task.controller[1..task.controller.length])
    render_js
  end

  private 

  def authenticate(username,password)
    ldap = initialize_ldap
    userdn = get_dn(username)
    if userdn.nil?
      flash[:notice] = "Login, failure, username not found"
      return false
    end
    if check_group(userdn)
      ldap.auth userdn, password
      if ldap.bind
        update_user(username)
        return true
      else
        flash[:notice] = "Login failure"
        return false
      end
    end
    flash[:notice] = "Insufficient rights"
    return false
  end
      
end

