class Network::SubnetDetailReport < BaseReport

  stage :list

  def setup
    ipv4_subnet = Ipv4Subnet.find(options.ipv4_subnet_id.to_i)
    cond = EZ::Where::Condition.new :ipv4_interfaces do
      ipv4_subnet_id == ipv4_subnet.id.to_i
    end
    puts cond.to_sql
    self.data = Ipv4Interface.report_table(:all, :include => { :interface => { :only => [:name], 
                                                   :include => { :device => { :only => [:description], :methods => ["to_label"] } } },
                                                  :ipv4_subnet  => {} }, 
                                         :only => ["ip_address"],
                                         :order => "ip_address_packed",
                                         :conditions => cond.to_sql)
    data.rename_columns("device.to_label" => "device", "device.description" => "description", "interface.name" => "interface")
    data.reorder("device", "description", "interface", "ip_address")
    data.column_names = data.column_names.collect{ |cn| cn.gsub(/\./, ' ').titleize }
    options[:subnet]=ipv4_subnet
  end

  formatter :html do
    build :list do
      output << "<h3>Subnet Detail Report</h3>"
      output << "Run Date: #{Time.now}<br/><br/>"
      output << "Network: #{options[:subnet].subnet.description}<br/>"
      output << "Subnet: #{options[:subnet].to_label}<br/>"
      output << "Gateway: #{options[:subnet].gateway_address}<br/><br/>"
      output << data.to_html
    end
  end

  formatter :pdf do
    build :list do
      pad(10) { add_text "Subnet Detail Report" }
      pad(5) { add_text "Run Date:  #{Time.now}", :font_size => 8 }
      pad(5) { add_text "Network: #{options[:subnet].subnet.description}", :font_size => 8 }
      pad(5) { add_text "Subnet: #{options[:subnet].to_label}", :font_size => 8 }
      pad(5) { add_text "Gateway: #{options[:subnet].gateway_address}", :font_size => 8 }
      draw_table data, {:width => 600} unless data.length == 0
      add_text "No data matched filter criteria" if data.length == 0
    end
  end

  formatter :csv do
    build :list do
      output << data.to_csv
    end
  end

end
