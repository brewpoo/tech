class Ordering::OutstandingItemsReport < BaseReport

  stage :list

  filters['number_days_old'] = options.number_days_old unless options.number_days_old.blank?

  def setup
    created_on_by = options.number_days_old.blank? ? 60.days : options.number_days_old.to_i.days

    cond = Caboose::EZ::Condition.new :requisition_items do
      condition :received_items do
        requisition_item_id == :null   
      end
      condition :requisitions do 
        requisition_status_id >= RequisitionStatus.find_by_value(Requisition::AWARDED)
        created_on < Time.now - created_on_by
      end
    end
    puts cond.to_sql
    self.data = RequisitionItem.report_table(:all, :include => { :requisition => { :only => [:created_on], :methods => ["to_label","days_old"],
                                                                  :include => { :vendor => { :only => [:name] } } }, 
                                                       :order_item => { :only => [], :include => { :product => { :only => [:full_name] } } },
                                                       :received_items => { :only => [] }  },
                                         :only => [:quantity, :unit_price],
                                         :conditions => cond.to_sql)
    data.rename_columns("product.full_name" => "product", "requisition.to_label" => "requisition", 
                        "requisition.vendor.name" => "vendor", "requisition.created_on" => "created_on", "requisition.days_old" => "days_old")
    data.reorder("created_on", "product", "quantity", "unit_price", "requisition", "vendor", "days_old")
    data.column_names = data.column_names.collect{ |cn| cn.gsub(/\./, ' ').titleize }
  end

  formatter :html do
    build :list do
      output << "<h3>Outstanding Items Report</h3>"
      output << "Run Date: #{Time.now}<br/>"
      output << data.to_html
    end
  end

  formatter :pdf do
    build :list do
      pad(10) { add_text "Outstanding Items Report" }
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
