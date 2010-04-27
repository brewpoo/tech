class Circuit::MpMappingReport < BaseReport

  stage :list

  def setup

    cond = EZ::Where::Condition.new :mp_pvcs do
    end
    puts cond.to_sql
    self.data = MpPvc.report_table(:all, :include => { :dlci_a => { :only => [:dlci],
                                            :include => { :mp_line => { :only => [],
                                              :include => { :device => { :record_class => [:device_a], :only => [:hostname] },
                                                            :circuit => { :only => [:circuit_number], 
                                                              :include => { :line_speed => { :only => [:speed] },
                                                                            :line_type => { :only => [:name] } } } } } } },
                                      :dlci_b => { :only => [:dlci],
                                            :include => { :mp_line => { :only => [],
                                              :include => { :device => { :record_class => [:device_b], :only => [:hostname] }, 
                                                            :circuit => { :only => [:circuit_number], 
                                                              :include => { :line_speed => { :only => [:speed] },
                                                                            :line_type => { :only => [:name] } } } } } } } },

                                         :only => [],
                                         #:order => "dlci_a.dlci, dlci_b.dlci",
                                         :conditions => cond.to_sql)
    #data.rename_columns("location.long_name" => "location", "device.hostname" => "device", "line_speed.speed" => "line_speed",
    #                    "line_type.name" => "line_type", "provider.name" => "provider", "circuit.circuit_number" => "circuit_number")
    #data.reorder("location", "device", "provider", "line_type", "line_speed", "circuit_number", "numbers") unless data.length == 0
    data.column_names = data.column_names.collect{ |cn| cn.gsub(/\./, ' ').titleize }
  end

  formatter :html do
    build :list do
      output << "<h3>Multi-Point Circuit Mapping Report</h3>"
      output << "Run Date: #{Time.now}<br/><br/>"
      output << data.to_html
    end
  end

  formatter :pdf do
    build :list do
      pad(10) { add_text "Multi-Point Circuit Mapping Report" }
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
