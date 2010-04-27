class Network::IpAgingReport < BaseReport

  stage :list

  filters['number_days_ago'] = options.number_days_ago unless options.number_days_ago.blank?

  def setup
    reverse_logic = false
    last_pinged_by = options.number_days_ago.blank? ? 60.days : options.number_days_ago.to_i.days
    if last_pinged_by < 0
      last_pinged_by = -last_pinged_by
      reverse_logic = true
    end 
    if reverse_logic == false
      cond = EZ::Where::Condition.new :ipv4_interfaces do
        any do
          last_pinged_on < Time.now - last_pinged_by
          last_pinged_on == :null
        end
        any do 
          is_stealth == false 
          is_stealth == :null
        end
        any do 
          is_reserved == false
          is_reserved == :null
        end
        any do
          is_virtual == false
          is_virtual == :null
        end
        condition :ipv4_subnets do
          condition :subnets do
            any do
              is_stealth == false
              is_stealth == :null
            end
            any do 
              is_reserved == false
              is_reserved == :null
            end
            any do
              is_local == false
              is_local == :null
            end
          end
        end
      end
    else
      cond = EZ::Where::Condition.new :ipv4_interfaces do
        last_pinged_on > Time.now - last_pinged_by
        ping_count > 0
      end
    end
    puts cond.to_sql
    self.data = Ipv4Interface.report_table(:all, :include => { :interface => { :only => [:name], 
                                                   :include => { :device => { :only => [:hostname], :include => { :device_class => { :only => [:name] } }  } } },
                                                  :ipv4_subnet  => { :include => { :subnet => { } } } }, 
                                         :only => ["ip_address", "ping_count", "last_pinged_on", "is_stealth", "is_reserved", "is_virtual"],
                                         :order => "ip_address_packed",
                                         :conditions => cond.to_sql)
    data.rename_columns("device.hostname" => "device", "device.description" => "description", 
      "interface.name" => "interface", "device_class.name" => "device_class")
    data.reorder("device", "device_class", "ip_address", "ping_count", "last_pinged_on")
    data.column_names = data.column_names.collect{ |cn| cn.gsub(/\./, ' ').titleize }
  end

  formatter :html do
    build :list do
      output << "<h3>IP Aging Report</h3>"
      output << "Run Date: #{Time.now}<br/><br/>"
      output << data.to_html
    end
  end

  formatter :pdf do
    build :list do
      pad(10) { add_text "IP Aging Report" }
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
