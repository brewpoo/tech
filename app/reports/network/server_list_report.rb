class Network::ServerListReport < BaseReport

  stage :list

  def setup
    operating_system = options.operating_system_id.blank? ? nil : options.operating_system_id.to_i

    cond = Caboose::EZ::Condition.new :devices do
      operating_system_id === OperatingSystem.find(operating_system).descendant_ids.flatten unless operating_system.nil? 
    end
    puts cond.to_sql
    self.data = Server.report_table(:all, :include => {  
                                         :operating_system  => { :only => [:long_name] },
                                         :primary_engineer => { :only => [], :methods => [:full_name] } }, 
                                         :only => [:hostname, :description], :methods => [:fqdn, :first_ip_address],
                                         :order => "hostname",
                                         :conditions => cond.to_sql)
    data.rename_columns("first_ip_address" => "ip_address", "operating_system.long_name" => "operating_system", 
      "primary_engineer.full_name" => "primary_engineer")
    data.reorder("hostname", "description", "fqdn", "ip_address", "operating_system", "primary_engineer") unless data.length == 0
    data.column_names = data.column_names.collect{ |cn| cn.gsub(/\./, ' ').titleize }
  end

  formatter :html do
    build :list do
      output << "<h3>Server List Report</h3>"
      output << "Run Date: #{Time.now}<br/><br/>"
      output << data.to_html
      output << "<br/>Count: #{data.length}"
    end
  end

  formatter :pdf do
    build :list do
      pad(10) { add_text "Server List Report" }
      pad(5) { add_text "Run Date:  #{Time.now}", :font_size => 8 }
      draw_table data, {:width => 600} unless data.length == 0
      add_text "No data matched filter criteria" if data.length == 0
      pad(5) { add_text "Count: #{data.length}", :font_size => 8 }
    end
  end

  formatter :csv do
    build :list do
      output << data.to_csv
    end
  end

end
