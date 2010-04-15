class Ordering::ClosedDetailReport < BaseReport

  stage :list

  def setup
    start_date = options.start_date.blank? ? Time.now - 180.days : Time.parse(options.start_date)
    end_date = options.end_date.blank? ? Time.now : Time.parse(options.end_date)
    order_type = options.order_type_id.blank? ? nil : options.order_type_id.to_i
    requestor = options.requestor_id.blank? ? nil : options.requestor_id.to_i
    cond = Caboose::EZ::Condition.new :orders do
      requestor_id == requestor unless requestor.nil?
      order_type_id == order_type unless order_type.nil?
      ordered_on <=> (start_date.to_s(:db)..end_date.to_s(:db))
      order_status_id == OrderStatus.find_by_value(Order::CLOSED)
    end
    puts cond.to_sql
    self.data = Order.report_table(:all, :include => { :requestor => { :only => [], :methods => ["to_label"] }, 
                                                       :order_type => { :only =>  :name } },
                                         :only => ["ordered_on", "requestor.to_label", "order_number", "description"],
                                         :methods => ["order_status" ],
                                         :order => "ordered_on",
                                         :conditions => cond.to_sql)
    data.rename_columns("requestor.to_label" => "requestor", "order_type.name" => "order_type")
    data.reorder("ordered_on", "requestor", "order_type", "description")
    data.column_names = data.column_names.collect{ |cn| cn.gsub(/\./, ' ').titleize }
  end

  formatter :html do
    build :list do
      output << "<h3>Closed Orders Details Report</h3>"
      output << "Run Date: #{Time.now}<br/>"
      output << data.to_html
    end
  end

  formatter :pdf do
    build :list do
      pad(10) { add_text "Closed Orders Details Report" }
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
