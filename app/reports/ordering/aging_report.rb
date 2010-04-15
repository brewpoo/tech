class Ordering::AgingReport < BaseReport

  stage :list

  filters['number_days_old'] = options.number_days_old unless options.number_days_old.blank?
  filters['order_type'] = OrderType.find(options.order_type_id.to_i).name unless options.order_type_id.blank?
  filters['requestor'] = User.find(options.requestor_id.to_i).to_label unless options.requestor_id.blank?

  def setup
    ordered_on_by = options.number_days_old.blank? ? 60.days : options.number_days_old.to_i.days
    order_type = options.order_type_id.blank? ? nil : options.order_type_id.to_i
    requestor = options.requestor_id.blank? ? nil : options.requestor_id.to_i
    cond = Caboose::EZ::Condition.new :orders do
      requestor_id == requestor unless requestor.nil?
      order_type_id == order_type unless order_type.nil?
      ordered_on < Time.now - ordered_on_by
      order_status_id < OrderStatus.find_by_value(Order::CLOSED).id
    end
    puts cond.to_sql
    self.data = Order.report_table(:all, :include => { :requestor => { :only => [], :methods => ["to_label"] }, 
                                                       :order_type => { :only =>  :name },
                                                       :order_status => { :only => :name }  },
                                         :only => ["ordered_on", "requestor.to_label", "order_number", "description"],
                                         :order => "ordered_on",
                                         :conditions => cond.to_sql)
    data.rename_columns("requestor.to_label" => "requestor", "order_status.name" => "order_status", "order_type.name" => "order_type")
    #data.reorder("ordered_on", "order_number", "requestor", "order_type", "description", "order_status")
    data.column_names = data.column_names.collect{ |cn| cn.gsub(/\./, ' ').titleize }
  end

  formatter :html do
    build :list do
      output << "<h3>Order Aging Report</h3>"
      output << "Run Date: #{Time.now}<br/>"
      output << data.to_html
    end
  end

  formatter :pdf do
    build :list do
      pad(10) { add_text "Order Aging Report" }
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
