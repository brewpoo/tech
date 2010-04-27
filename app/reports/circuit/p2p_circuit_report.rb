class Circuit::P2pCircuitReport < BaseReport

  stage :list

  def setup
    provider = options.provider_id.blank? ? nil : options.provider_id.to_i
    line_type = options.line_typeid.blank? ? nil :  options.line_type_id.to_i

    cond = EZ::Where::Condition.new :pp_lines do
      conditions :circuit do
        provider_id == provider unless provider.nil?
        line_type_id == line_type unless line_type.nil?
      end
    end
    puts cond.to_sql
    self.data = PpLine.report_table(:all, :include => { :circuit => { :only => [:circuit_number],
                                            :include => { :provider => { :only => [:name] },
                                                          :line_speed => { :only => [:speed] },
                                                          :line_type => { :only => [:name] } } },
                                                        :subnet => { :only => [], :methods => ["to_label"] } }, 
                                         :only => ["map_reference"], :methods => ["location_a", "location_b"],
                                         :order => "map_reference",
                                         :conditions => cond.to_sql)
    data.rename_columns("subnet.to_label" => "network_address", "circuit.circuit_number" => "circuit_number", "line_speed.speed" => "line_speed",
                        "line_type.name" => "line_type", "provider.name" => "provider")
    data.reorder("map_reference", "network_address", "provider", "line_type", "line_speed", "circuit_number", "location_a", "location_b") unless data.length == 0
    data.column_names = data.column_names.collect{ |cn| cn.gsub(/\./, ' ').titleize }
  end

  formatter :html do
    build :list do
      output << "<h3>Point-to-Point Circuit Report</h3>"
      output << "Run Date: #{Time.now}<br/><br/>"
      output << data.to_html
    end
  end

  formatter :pdf do
    build :list do
      pad(10) { add_text "Point-to-Point Circuit Report" }
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
