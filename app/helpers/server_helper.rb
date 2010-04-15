module ServerHelper

  def management_url_column(record)
    return "<a href='#{record.management_url}' target='_blank'>#{record.management_url}</a>" unless record.management_url.blank?
    return nil
  end

  def hostname_column(record)
      link_to h(record.hostname), { :controller => 'device', :action => 'edit', :id => record }, :popup => true 
  end

  def product_form_column(record, input_name)
    selected = record.product ? record.product.id : nil
    collection_select(:record, :product_id, Product.find(:all, :conditions=>['device_class_id=?',DeviceClass.find_by_name("Server")]), :id, :full_name, {:prompt => true},  {:name => input_name})
  end

end
