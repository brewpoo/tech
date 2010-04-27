class Projecting::ProjectDetailReport < BaseReport

  stage :list

  def setup
    project = Project.find(options.project_id.to_i)

    cond = EZ::Where::Condition.new :project_updates do
      project_id == project.id.to_i
    end
    puts cond.to_sql
    self.data = ProjectUpdate.report_table(:all, :only => [:created_by, :updated_on, :body],
                                         :order => "updated_on desc",
                                         :conditions => cond.to_sql)
    #data.rename_columns("manager.full_name" => "manager", "project_status.name" => "project_status", 
    #  "project_type_and_number" => "project_number")
    #data.reorder("project_number", "title", "manager", "project_status", "latest_update", "total_spent") unless data.length == 0
    data.column_names = data.column_names.collect{ |cn| cn.gsub(/\./, ' ').titleize }
    options[:project]=project
  end

  formatter :html do
    build :list do
      output << "<h3>Project Detail Report</h3>"
      output << "Run Date: #{Time.now}<br/><br/>"
      output << "Project: #{options[:project].to_label}<br/>"
      output << "Manager: #{options[:project].manager.full_name}<br/>"
      output << "Project Status: #{options[:project].project_status.name}<br/>"
      output << "Requested On: #{options[:project].requested_on}<br/>"
      output << "Started On: #{options[:project].started_on}<br/>"
      if options[:project].project_status == ProjectStatus.find_by_name("Complete")
        output << "Completed On: #{options[:project].completed_on}<br/>"
      else
        output << "Estimated Completion: #{options[:project].estimated_completion}<br/>"
      end
      output << "Total Spent: #{options[:project].total_spent.to_currency}<br/>" unless !options[:project].orders
      output << "<br/><h3>Project Updates</h3><br/>"
      
      output << data.to_html
    end
  end

  formatter :pdf do
    build :list do
      pad(10) { add_text "Project Detail Report" }
      pad(5) { add_text "Run Date:  #{Time.now}", :font_size => 8 }
      pad(5) { add_text "Project:  #{options[:project].to_label}", :font_size => 8 }
      pad(5) { add_text "Manager:  #{options[:project].manager.full_name}", :font_size => 8 }
      pad(5) { add_text "Project Status:  #{options[:project].project_status.name}", :font_size => 8 }
      pad(5) { add_text "Requested On:  #{options[:project].requested_on}", :font_size => 8 }
      pad(5) { add_text "Started On:  #{options[:project].started_on}", :font_size => 8 }
      if options[:project].project_status == ProjectStatus.find_by_name("Complete")
        pad(5) { add_text "Completed On:  #{options[:project].completed_on}", :font_size => 8 }
      else
        pad(5) { add_text "Estimated Completion:  #{options[:project].estimated_completion}", :font_size => 8 }
      end
      pad(5) { add_text "Total Spent:  #{options[:project].total_spent.to_currency}", :font_size => 8 } unless !options[:project].orders
      pad(5) { add_text "Project Updates" }

      draw_table data, {:width => 600}  unless data.length == 0
      add_text "No Updates", :font_size => 8 if data.length == 0
    end
  end

  formatter :csv do
    build :list do
      output << data.to_csv
    end
  end

end
