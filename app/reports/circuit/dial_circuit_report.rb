class Circuit::DialCircuitReport < BaseReport

  stage :list

  def setup

    cond = EZ::Where::Condition.new :dial_lines do
    end
    puts cond.to_sql
    self.data = DialLine.report_table(:all, :include => { :device => { :only => [:hostname],
                                            :include => { :equipment => { :only => [], :include => { :location => { :only => [:long_name] } } } } },
                                              :circuit => { :only => [:circuit_number], :include => { :provider => { :only => [:name] },
                                                          :line_speed => { :only => [:speed] },
                                                          :line_type => { :only => [:name] } } } }, 
                                         :only => [], :methods => ["numbers"],
                                         :order => "devices.hostname",
                                         :conditions => cond.to_sql)
    data.rename_columns("location.long_name" => "location", "device.hostname" => "device", "line_speed.speed" => "line_speed",
                        "line_type.name" => "line_type", "provider.name" => "provider", "circuit.circuit_number" => "circuit_number")
    data.reorder("location", "device", "provider", "line_type", "line_speed", "circuit_number", "numbers") unless data.length == 0
    data.column_names = data.column_names.collect{ |cn| cn.gsub(/\./, ' ').titleize }
  end

  formatter :html do
    build :list do
      output << "<h3>Dial Line Circuit Report</h3>"
      output << "Run Date: #{Time.now}<br/><br/>"
      output << data.to_html
    end
  end

  formatter :pdf do
    build :list do
      pad(10) { add_text "Dial Line Circuit Report" }
      pad(5) { add_text "Run Date:  #{Time.now}", :font_size => 8 }
      draw_table data unless data.length == 0
      add_text "No data matched filter criteria" if data.length == 0
    end
  end

  formatter :csv do
    build :list do
      output << data.to_csv
    end
  end

end
