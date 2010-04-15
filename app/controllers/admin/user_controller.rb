class Admin::UserController < Admin::BaseController

  active_scaffold :user do |config|
    list.columns = [:username, :contact, :roles, :last_login, :logged_in]
    create.columns = update.columns = [:username, :contact, :roles]
    active_scaffold_config.action_links.add('refresh',
                                            :label => 'Refresh',
                                            :type => :record,
                                            :inline => false)
    active_scaffold_config.action_links.add('send_message',
                                            :label => 'Send Message',
                                            :type => :table,
                                            :inline => false)
    list.sorting = { :username => :asc }
    list.per_page = 50
    columns[:contact].form_ui = :select
    columns[:roles].form_ui = :select
    columns[:logged_in].form_ui = :checkbox
  end

  def refresh
  # Update or create related Contact record
  # This only works for LDAP users
    @user=User.find(params[:id])
    @user.dn = get_dn(@user.username)
    @contact = @user.contact || Contact.new
    @contact.last_name = ldap_get(@user.username,'sn')
    @contact.first_name = ldap_get(@user.username,'givenName')
    @contact.title = ldap_get(@user.username,'title')
    @contact.employee_number = ldap_get(@user.username, 'employeeID')
    @contact.email = ldap_get(@user.username, 'mail').downcase
    @contact.employer = Company.find(:first)
    if !@contact.phones
      @contact.phones << Phone.create(:number => ldap_get(@user.username, 'telephoneNumber'), :phone_type => PhoneType.find_by_phone_type("Work"))
    end
    if @contact.new_record?
      @user.contact = @contact
    end
    @user.save!
    @contact.save!
    flash[:info] = "User's contact details updated"
    redirect_to :back
  end

  def send_message
    @roles=Role.find(:all)
    if request.post?
      if params[:role].nil? or params[:content].blank?
        flash[:notice]="No contacts found or message empty"
        redirect_to :action => 'list' and return
      end

      emails=[]
      params[:role].each do |key,value|
        emails << Role.find_by_flag(key).user_emails 
      end
      emails.uniq!
      Notifier.deliver_send_message(emails,params[:content]) 
      flash[:notice]="Message sent"
      redirect_to :action => 'list' and return
    end
  end

end
