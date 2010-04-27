class Network::SubnetSummaryReport < BaseReport

  stage :list

  def setup
    network_class = options.network_class_id.blank? ? nil : options.network_class_id.to_i
    topology = options.topology_id.blank? ? nil :  options.topology_id.to_i

    cond = EZ::Where::Condition.new :subnets do
      network_class_id == network_class unless network_class.nil? 
      topology_id == topology unless topology.nil? 
    end
    puts cond.to_sql
    self.data = Subnet.report_table(:all, :include => { :ipv4_subnet => { :only => [:subnet_address_packed], :methods => ["to_label", "usage"] }, 
                                         :network_class  => { :only => [:name] },
                                         :topology => { :only => [:name]  } }, 
                                         :only => ["description"], :methods => ["vlan"],
                                         :order => "ipv4_subnets.subnet_address_packed",
                                         :conditions => cond.to_sql)
    data.rename_columns("ipv4_subnet.to_label" => "network_address", "network_class.name" => "network_class", 
      "ipv4_subnet.usage" => "subnet_usage", "topology.name" => "topology")
    data.reorder("network_address", "vlan", "description", "network_class", "topology", "subnet_usage") unless data.length == 0
    data.column_names = data.column_names.collect{ |cn| cn.gsub(/\./, ' ').titleize }
  end

  formatter :html do
    build :list do
      output << "<h3>Subnet Summary Report</h3>"
      output << "Run Date: #{Time.now}<br/><br/>"
      output << data.to_html
    end
  end

  formatter :pdf do
    build :list do
      pad(10) { add_text "Subnet Summary Report" }
      pad(5) { add_text "Run Date:  #{Time.now}", :font_size => 8 }
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
