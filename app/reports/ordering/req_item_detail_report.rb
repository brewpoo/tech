class Ordering::ReqItemDetailReport < BaseReport

  stage :list

  filters['start_date'] = options.start_date unless options.start_date.blank?
  filters['end_date'] = options.end_date unless options.end_date.blank?
  filters['order_type'] = OrderType.find(options.order_type_id.to_i).name unless options.order_type_id.blank?
  filters['product'] = options.product unless options.product.blank?

  def setup
    start_date = options.start_date.blank? ? Time.now - 365.days : Time.parse(options.start_date)
    end_date = options.end_date.blank? ? Time.now : Time.parse(options.end_date)
    order_type = options.order_type_id.blank? ? nil : options.order_type_id.to_i
    product = options.product.blank? ? nil : options.product

    cond = Caboose::EZ::Condition.new :requisition_items do
      condition :order_items do
        condition :orders do 
          order_type_id == order_type unless order_type.nil?
        end
        condition :products do
          full_name =~ "%#{product}%" unless product.nil?
        end
      end
      condition :requisitions do 
        created_on >= start_date
        created_on <= end_date
      end
    end
    puts cond.to_sql
    self.data = RequisitionItem.report_table(:all, :include => { :requisition => { :only => [:created_on], :methods => ["to_label"],
                                                                  :include => { :requisition_status => { :only => [], :methods => ["to_label"] },
                                                                  :vendor => { :only => [], :methods => ["to_label"]}  } }, 
                                                       :order_item => { :only => [], :include => { :product => { :only => [:full_name] },
                                                       :order => { :only => [], :include => { :order_type => { :only => [] }} }  } },
                                                       :received_items => { :only => [] }  },
                                         :only => [:quantity, :unit_price], :methods => [:line_price],
                                         :conditions => cond.to_sql)
    data.rename_columns("product.full_name" => "product", "requisition.to_label" => "requisition", 
                        "requisition.created_on" => "created_on", "vendor.to_label" => "vendor", 
                        "line_price" => "extended_price", "requisition_status.to_label" => "requisition_status")
    #data.reorder("created_on", "product", "quantity", "unit_price", "extended_price", "requisition", "requisition_status", "vendor")
    data.column_names = data.column_names.collect{ |cn| cn.gsub(/\./, ' ').titleize }
  end

  formatter :html do
    build :list do
      output << "<h3>Requisiiton Items Detail Report</h3>"
      output << "Run Date: #{Time.now}<br/>"
      output << data.to_html
    end
  end

  formatter :pdf do
    build :list do
      pad(10) { add_text "Requisition Items Detail Report" }
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
