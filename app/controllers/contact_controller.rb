class ContactController < ApplicationController

  active_scaffold :contact do |config|
    list.columns = [:last_name, :first_name, :employer, :title, :department, :location, :email]
    show.columns = [:full_name, :employer, :title, :department, :location, :email, :manager, 
      :description, :notes, :is_purchase_contact, :is_manager, :is_engineer]
    list.per_page = 50
    list.sorting = {:last_name => :asc}
    update.columns = create.columns = [:first_name, :last_name, :employer, :employee_number, :title, :department, 
      :phones, :location, :email, :manager, :notes, :is_purchase_contact, :is_manager, :is_engineer]
    columns[:employer].form_ui = :select
    columns[:department].form_ui = :select
    columns[:location].form_ui = :select
    columns[:is_purchase_contact].label = 'Purchase Contact?'
    columns[:is_purchase_contact].form_ui = :checkbox
    columns[:is_manager].label = "Manager?"
    columns[:is_manager].form_ui = :checkbox
    columns[:is_engineer].label = "Engineer?"
    columns[:is_engineer].form_ui = :checkbox
    columns.exclude :devices
    nested.add_link("Wireless", [:wireless_interfaces])
    nested.add_link("Phones", [:phones])
    subform.columns = [:first_name, :last_name, :employer, :title, :phones, :email, :is_purchase_contact]
    action_links.add('merge_contacts', :label => 'Merge Contacts', :type => :table, :crud_type => :update, :inline => false)
  end

  def employer_changed
    return unless request.xhr?
    @departments = Department.find(:all, :order=> 'name', :conditions => ['company_id = ?', params[:id]]).map { |m| [m.name, m.id]}
  end

  def add_contact
    if request.post?
      @contact = Contact.new(:last_name => params[:last_name], :first_name => params[:first_name])
      @contact.employer = Company.find(params[:employer].to_i)
      unless params[:department].first.empty?
        @contact.department = Department.find(params[:department].first.to_i)
      end
      @contact.save
      if !@contact.new_record?
        flash[:notice] = "Contact #{@contact.full_name} Added"
      else
        flash[:notice] = 'Failed to add contact'
      end
      @contacts = Contact.company_contacts_select(this_user.contact.employer)
      render_js
    end
  end

  def new_contact
    return unless request.xhr?
    @contact = Contact.new(:employer => Company.find(params[:employer].to_i))
    @departments = Company.find(params[:employer].to_i).departments.sort_by{|d| d.name}.map{|d|[d.name,d.id]}
    @employers = Company.map_select
    render_js
  end

  def merge_contacts
    @contacts=Contact.find(:all).sort_by{|p| p.last_first}.map{|p| ["#{p.last_first} [#{p.used}]", p.id]}
    if request.post?
      from=Contact.find(params[:merge_from][:id].to_i)
      to=Contact.find(params[:merge_to][:id].to_i)
      if from.user
        flash[:notice]='Cannot merge, source has associated user!!'
        redirect_to :action => 'list' and return
      end
      if from.locations
        from.locations.each do |l|
          l.contact=to
          l.save
        end
      end
      if from.devices
        from.devices.each do |d|
          d.contact=to
          d.save
        end
      end
      if from.distributed_items
        from.distributed_items.each do |i|
          i.contact=to
          i.save
        end
      end
      if from.wireless_interfaces
        from.wireless_interfaces.each do |w|
          w.contact=to
          w.save
        end
      end
      if from.phones
        from.phones.each do |p|
          p.phonable=to
          p.save
        end
      end
      if from.companies
        from.companies.each do |c|
          c.contact=to
          c.save
        end
      end
      if from.orders
        from.orders.each do |o|
          o.manager=to
          o.save
        end
      end
      if from.managed_projects
        from.managed_projects.each do |p|
          p.manager=to
          p.save
        end
      end
      if from.requested_projects
        from.requested_projects.each do |p|
          p.requestor=to
          p.save
        end
      end
      if from.engineer_projects
        from.engineer_projects.each do |p|
          p.engineer=to
          p.save
        end
      end

      from.destroy
      flash[:notice]="Contacts have been merged"
      redirect_to :action => 'list' and return
    end
  end

  def all_contacts
    return unless request.xhr?
    @contacts = Contact.select
    render_js
  end

end
