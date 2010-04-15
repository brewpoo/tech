module Admin::OrderHelper

  def order_items_column(record)
    output = '<table>'
    record.order_items.each { |item|
      output += "<tr><td>#{item.quantity}</td><td>x</td><td>#{item.description}</td>
                     <td>@ #{item.unit_price.to_f.to_currency} each #{item.line_price.to_f.to_currency} extended
                     #{item.item_status}</td></tr>"
    }
    output += "</table>"
    return output
  end

  def requisitions_column(record)
    output = ''
    record.requisitions.each { |r|
      link = link_to h(r.to_label), :controller => '/requisition', :action => 'show', :id => r.id
      output += link + "<br/>"
    }
    return output
  end

  def total_cost_column(record)
    return number_to_currency(record.total_cost) if record.total_cost>0
    return 'n/a'
  end

end
