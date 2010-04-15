class ProjectController < ApplicationController

  active_scaffold :project do |config|
    columns.add  :project_type_and_number, :total_spent
    list.columns = [:project_type_and_number, :title, :started_on, :manager, :lead_engineer, :requestor, :department, :project_status, :priority]
    list.per_page = 50
    list.sorting = {:project_number => :desc}
    create.columns = update.columns = [:project_type, :project_number, :title, :description, :comments, :requested_on, :started_on, :estimated_completion, 
      :completed_on, :priority, :project_status, :service_request,
      :requestor, :department, :manager, :lead_engineer, :engineers] 
    show.columns = [:project_type, :project_type_and_number, :title, :description, :comments, :requested_on, :started_on, :estimated_completion, 
      :project_status, :completed_on, :manager, :requestor, :department, :service_request, :lead_engineer, :priority, :engineers, 
      :project_updates, :links, :attachments, :orders, :total_spent, :created_on, :created_by, :updated_on]
    create.link.page = update.link.page = true
    columns[:priority].form_ui = :select
    columns[:project_type].form_ui = :select
    columns[:project_status].form_ui = :select
    columns[:department].form_ui = :select
    columns[:requestor].form_ui = :select
    columns[:manager].form_ui = :select
    columns[:lead_engineer].form_ui = :select
    columns[:engineers].form_ui = :select
    columns[:project_type_and_number].label = "Project Number"
    # Searching and Sorting
    columns[:project_type_and_number].includes = [:project_type]
    columns[:project_type_and_number].sort_by :sql => 'project_number+0'
    columns[:project_type_and_number].search_sql = 'concat(project_types.abbreviation,project_number)'
    columns[:manager].search_sql = 'contacts.last_name'
    columns[:manager].sort_by :sql => 'contacts.last_name'
    columns[:lead_engineer].search_sql = 'lead_engineers_projects.last_name'
    columns[:lead_engineer].sort_by :sql => 'lead_engineers_projects.last_name'
    columns[:requestor].search_sql = 'requestors_projects.last_name'
    columns[:requestor].sort_by :sql => 'requestors_projects.last_name'
    columns[:department].search_sql = 'departments.name'
    columns[:department].sort_by :sql => 'departments.name'

    search.columns << [:project_type_and_number, :manager, :lead_engineer, :requestor, :department]
    # Filter Config
    config.actions.add :list_filter
    config.list_filter.add(:association, :project_type, {:label => "Project Type", :association => [:project_type]})
    config.list_filter.add(:association, :project_status, {:label => "Project Status", :association => [:project_status]})
    config.list_filter.add(:association, :priority, {:label => "Priority", :association => [:priority]})
    # Nested links
    nested.add_link("Links", [:links])
    nested.add_link("Attachments", [:attachments])
    nested.add_link("Updates", [:project_updates])
    #action_links.add('merge_projects', :label => 'Merge Projects', :type => :table, :crud_type => :update, :inline => false)
  end

  def do_update_column
    old_column = params[:column]
    params[:column] = active_scaffold_config.columns[params[:column]].association.try(:primary_key_name) || old_column # inplace_edit in associations send the id
    super
    params[:column] = old_column
  end

  def add_project
    if request.post?
      session[:caller]=@caller
      @project = Project.new(:project_number => params[:project_number], :title => params[:title],
        :description => params[:description], :comments => params[:comments], :created_by => this_user.to_label)
      @project.save
      if !@project.new_record?
        flash[:notice] = "Project #{@project.project_number} Added"
      else
        flash[:notice] = 'Failed to add project'
      end
      @projects = Project.select_map
      render_js
    end
  end

  def new_project
    return unless request.xhr?
    @project = Project.new
    render_js
  end

  def project_type_changed
    return unless request.xhr?
    @new_project_number = Project.next_project_number(ProjectType.find(params[:id]))
    render_js
  end

  def merge_projects
    @projects=Project.find(:all).sort_by{|p| p.project_number}.map {|p| ["#{p.project_type_and_number} - #{p.title}", p.id]}

    if request.post?
      from=Project.find(params[:merge_from][:id].to_i)
      to=Project.find(params[:merge_to][:id].to_i)
      if from.orders
        from.orders.each do |o|
          o.project=to
          o.save
        end
      end
      if from.attachments
        from.attachments.each do |a|
          a.attachable=to
          a.save
        end
      end
      if from.links
        from.links.each do |l|
          l.linkable=to
          l.save
        end
      end
      from.destroy
      flash[:notice]="Projects have been merged"
      redirect_to :action => 'list' and return
    end

  end

end
