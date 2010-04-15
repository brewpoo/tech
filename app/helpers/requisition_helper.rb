module RequisitionHelper

  def add_note_link(name)
    button_to_function name do |page|
      page.insert_html :bottom, :notes, :partial => 'note', :object => Note.new
    end
  end

  def requisition_items_column(record)
    output = ''
    record.requisition_items.each { |item|
      link = link_to h("Order #{item.order_item.order.order_number}/#{item.order_item.order.budget_string}"), :controller => '/order_budget', :action => 'edit', :id => item.order_item.order.id
      output += "#{item.to_label} (" + link + ")<br/>"
    }
    return output
  end

  def orders_column(record)
    output = ''
    record.orders.each { |r|
      link = link_to h("#{r.description} (#{r.order_number})"), :controller => '/order', :action => 'show', :id => r.id
      output += link + "<br/>"
    }
    return output
  end

  def total_cost_column(record)
    return number_to_currency(record.total_cost) if record.total_cost>0
    return 'n/a'
  end

end
