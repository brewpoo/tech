module Admin::RequisitionHelper

  def requisition_items_column(record)
    output = ''
    record.requisition_items.each { |item|
      output += "#{item.to_label}<br/>"
    }
    return output
  end

  def orders_column(record)
    output = ''
    record.orders.each { |r|
      link = link_to h(r.description), :controller => '/order', :action => 'show', :id => r.id
      output += link + "<br/>"
    }
    return output
  end

  def total_cost_column(record)
    return number_to_currency(record.total_cost) if record.total_cost>0
    return 'n/a'
  end

end
