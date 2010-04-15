class Projecting::ProjectTrackerReport < BaseReport

  stage :list

  def setup
    project_status = options.project_status_id.blank? ? nil : options.project_status_id.to_i
    priority = options.priority_id.blank? ? nil : options.priority_id.to_i
    manager = options.manager_id.blank? ? nil : options.manager_id.to_i
    lead_engineer = options.lead_engineer_id.blank? ? nil : options.lead_engineer_id.to_i

    cond = Caboose::EZ::Condition.new :projects do
      project_type_id == ProjectType.find_by_abbreviation("PN")
      project_status_id == project_status unless project_status.nil?
      priority_id == priority unless priority.nil?
      manager_id == manager unless manager.nil?
      lead_engineer_id == lead_engineer unless lead_engineer.nil?
    end
    puts cond.to_sql
    self.data = Project.report_table(:all, :include => { :manager => { :only => [], :methods => ["full_name"] }, 
                                                         :lead_engineer => { :only => [], :methods => ["full_name"] },
                                                         :requestor => { :only => [], :methods => ["full_name"] },
                                                         :department => { :only => [], :methods => ["to_label"] },
                                                         :project_status => { :only => [:name]},
                                                         :priority => { :only => [:name]} },
                                         :only => ["title", "description", "comments", "requested_on", "started_on", "estimated_completion",
                                                   "completed_on"], :methods => ["project_type_and_number", "total_spent", "latest_update"],
                                         :order => "projects.project_number",
                                         :conditions => cond.to_sql)
    data.rename_columns("manager.full_name" => "manager", "lead_engineer.full_name" => "lead_engineer", "requestor.full_name" => "requestor",
      "department.to_label" => "department", "project_status.name" => "project_status", "priority.name" => "priority",
      "project_type_and_number" => "project_number")
    data.reorder("project_number", "title", "requested_on", "started_on", "estimated_completion", "completed_on", "priority", "manager",
      "lead_engineer", "department", "requestor", "project_status", "total_spent", 
      "latest_update") unless data.length == 0
    data.column_names = data.column_names.collect{ |cn| cn.gsub(/\./, ' ').titleize }
  end

  formatter :html do
    build :list do
      output << "<h3>Project Tracker Report</h3>"
      output << "Run Date: #{Time.now}<br/><br/>"
      output << data.to_html
    end
  end

  formatter :pdf do
    build :list do
      apply_template()
      pad(10) { add_text "Project Tracker Report" }
      pad(5) { add_text "Run Date:  #{Time.now}", :font_size => 8 }
      draw_table data, {:font_size => 8} unless data.length == 0
      add_text "No data matched filter criteria", :font_size => 8 if data.length == 0
    end
  end

  formatter :csv do
    build :list do
      output << data.to_csv
    end
  end

end
