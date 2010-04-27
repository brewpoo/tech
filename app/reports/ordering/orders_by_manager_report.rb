class Ordering::OrdersByManagerReport < BaseReport

  stage :list

  def setup
    start_date = options.start_date.blank? ? Date.new(Time.now.year, 1 ,1 ) : Time.parse(options.start_date)
    end_date = options.end_date.blank? ? Time.now : Time.parse(options.end_date)
    supervisor = options.manager_id.blank? ? nil : options.manager_id.to_i
    order_type = options.order_type_id.blank? ? nil : options.order_type_id.to_i
    order_status = options.order_status_id.blank? ? nil : options.order_status_id.to_i
    managers = Contact.find(supervisor).find_subordinates  unless supervisor.nil?
    managers << Contact.find(supervisor) unless supervisor.nil?
    cond = EZ::Where::Condition.new :orders do
      order_type_id == order_type unless order_type.nil?
      ordered_on <=> (start_date.to_s(:db)..end_date.to_s(:db))
      order_status_id == order_status unless order_status.nil?
      #manager_id === managers unless supervisor.nil?
    end
    puts cond.to_sql
    self.data = Order.report_table(:all, :include => { :requestor => { :only => [], :methods => ["to_label"],
                                                        :include => { :contact => { :only => [],
                                                        :include => { :manager => { :only => [], :methods => ["to_label"] } } } } },
                                                       :order_type => { :only =>  :name },
                                                       :order_status => { :only => :name } },
                                         :only => ["ordered_on", "order_number", "description", "management_center"],
                                         :methods => ["earliest_purchased_on", "purchase_orders", "total_price","project_short"],
                                         :conditions => cond.to_sql)
    data.rename_columns("requestor.to_label" => "requestor", "order_type.name" => "order_type",
                         "manager.to_label" => "manager", "order_status.name" => "order_status",
                         "project_short" => "project", "earliest_purchased_on" => "purchased_on")
    data.reorder("manager", "requestor", "order_number", "ordered_on", "purchased_on", "project",  "management_center", "order_type",
                 "description", "order_status", "purchase_orders", "total_price")
    data.column_names = data.column_names.collect{ |cn| cn.gsub(/\./, ' ').titleize }
  end

  formatter :html do
    build :list do
      grouping=Grouping(data,:by => "Manager")
      output << "<h3>Orders by Manager Report</h3>"
      output << "Run Date: #{Time.now}<br/>"
      output << grouping.to_html
    end
  end

  formatter :pdf do
    build :list do
      pad(10) { add_text "Orders by Manager Report" }
      pad(5) { add_text "Run Date:  #{Time.now}", :font_size => 8 }
      draw_table data unless data.length == 0
      add_text "No data matched filter criteria" if data.length == 0
    end
  end

  formatter :csv do
    build :list do
      grouping=Grouping(data, :by => "Manager")
      output << grouping.to_csv
    end
  end

end
