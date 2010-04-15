module OrderHelper

  def add_note_link(name)
    button_to_function name do |page|
      page.insert_html :bottom, :notes, :partial => 'note', :object => Note.new
    end
  end

  def add_manufacturer_link
    link_to_function image_tag('add.gif'), "new Ajax.Request('/order/new_manufacturer');"
  end

  def add_product_family_link
    link_to_function image_tag('add.gif'), "new Ajax.Request('/order/new_product_family?manufacturer='+$('active-order-item').down('.manufacturer')[$('active-order-item').down('.manufacturer').selectedIndex].value);"
  end

  def add_product_link
    link_to_function image_tag('add.gif'), "new Ajax.Request('/order/new_product?product_family='+$('active-order-item').down('.product-family')[$('active-order-item').down('.product-family').selectedIndex].value);"
  end

  def add_item_link(name)
    button_to_function "Add Item", "new Ajax.Request('/order/add_order_item?product='+$('active-order-item').down('.product')[$('active-order-item').down('.product').selectedIndex].value+'&count='+$('active-order-item').down('.quantity').value+'&unit_price='+$('active-order-item').down('.unit-price').value);"
  end

  def add_details_link(item)
    link_to_function "Details", "new Ajax.Request('/order/add_details?item=#{item}');"
  end

  def find_item_link(name)
    button_to_function name, "new Ajax.Request('/order/find_product');"
  end

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

  def project_column(record)
    return if record.project.nil?
      this_controller = "project"
      this_controller = "project_tracker" if record.project.project_type == ProjectType.find_by_abbreviation("PN")
      this_controller = "project_whiteboard" if record.project.project_type == ProjectType.find_by_abbreviation("WB")
      return link_to h(record.project.project_type_and_number), { :controller => this_controller, :action => 'show', :id => record.project}, :popup => true
  end

end
