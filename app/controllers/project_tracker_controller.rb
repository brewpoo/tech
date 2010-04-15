class ProjectTrackerController < ProjectController

  before_filter :setup_active_scaffold

  def conditions_for_collection
    ['project_type_id = ?', ProjectType.find_by_abbreviation("PN")]
  end

  def setup_active_scaffold
    active_scaffold_config.list.label = "Project Tracker"
  end

  def do_new
    project_type=ProjectType.find_by_abbreviation("PN")
    @record = Project.new(:project_type => project_type, :manager => current_user.contact,
      :project_status => ProjectStatus.find_by_value(0), :priority => Priority.find_by_value(5),
      :project_number => Project.next_project_number(project_type), :requested_on => Time.now)
  end

end
