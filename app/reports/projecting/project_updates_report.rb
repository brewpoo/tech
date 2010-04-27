class Projecting::ProjectUpdatesReport < BaseReport

  stage :list

  def setup
    project_type = options.project_type_id.blank? ? nil : options.project_type_id.to_i
    project_status = options.project_status_id.blank? ? nil : options.project_status_id.to_i
    priority = options.priority_id.blank? ? nil : options.priority_id.to_i
    manager = options.manager_id.blank? ? nil : options.manager_id.to_i
    lead_engineer = options.lead_engineer_id.blank? ? nil : options.lead_engineer_id.to_i

    cond = EZ::Where::Condition.new :projects do
      project_type_id == project_type unless project_type.nil?
      project_status_id == project_status unless project_status.nil?
      priority_id == priority unless priority.nil?
      manager_id == manager unless manager.nil?
      lead_engineer_id == lead_engineer unless lead_engineer.nil?
    end
    puts cond.to_sql
    self.data = Project.report_table(:all, :include => { :manager => { :only => [:last_name] },
                                                         :project_status => { :only => [:name]} },
                                         :only => ["title"], :methods => ["project_type_and_number", "total_spent", "latest_update"],
                                         :order => "project_type_id, projects.project_number desc",
                                         :conditions => cond.to_sql)
    data.rename_columns("manager.last_name" => "manager", "project_status.name" => "project_status", 
     "project_type_and_number" => "project_number")
    data.reorder("project_number", "title", "manager", "project_status", "latest_update", "total_spent") unless data.length == 0
    data.column_names = data.column_names.collect{ |cn| cn.gsub(/\./, ' ').titleize }
  end

  formatter :html do
    build :list do
      output << "<h3>Project Updates Report</h3>"
      output << "Run Date: #{Time.now}<br/><br/>"
      output << data.to_html
    end
  end

  formatter :pdf do
    build :list do
      pad(10) { add_text "Project Updates Report" }
      pad(5) { add_text "Run Date:  #{Time.now}", :font_size => 8 }
      draw_table data, {:width => 600} unless data.length == 0
      add_text "No data matched filter criteria", :font_size => 8 if data.length == 0
    end
  end

  formatter :csv do
    build :list do
      output << data.to_csv
    end
  end

end
