module ProjectHelper

  def links_column(record)
    output = ''
    record.links.each { |l|
      link = link_to h(l.to_label), l.url, :popup => true
      output += link + "<br/>"
    }
    return output
  end

  def attachments_column(record)
    output = ''
    record.attachments.each { |a|
      link = link_to h(a.to_label), { :controller => 'attachment', :action => 'download', :id => a}
      output += link + "<br/>"
    }
    return output
  end

  def manager_column(record)
    return record.manager.full_name unless record.manager.nil?
  end

  def lead_engineer_column(record)
    return record.lead_engineer.full_name unless record.lead_engineer.nil?
  end

  def requestor_column(record)
    return record.requestor.full_name unless record.requestor.nil?
  end

  def total_spent_column (record)
    return record.total_spent if record.total_spent.class == String
    return record.total_spent.to_currency
  end

  def orders_column(record)
    output= ''
    record.orders.each { |o|
      link = link_to h(o.to_label), { :controller => 'order', :action => 'show', :id => o}, :popup => true
      output += link + "<br/>"
    }
    return output
  end

  def project_updates_column(record)
    return nil unless record.project_updates
    update = record.project_updates.last
    return "On #{update.created_on} by #{update.created_by}: #{update.body}"
  end


  #def project_type_form_column(record,input_name)
  #  selected = record.has_project_type? ? record.project_type.id : nil
  #  select :record, :project_type, ProjectType.type_select, { :name => input_name, :prompt => 'Choose project type',
  #    :selected => selected }, { :onchange => "new Ajax.Request('/project/project_type_changed/' + this[this.selectedIndex].value,
  #    { asynchronous:true, evalScripts:true});", :class => 'project-type', :disabled => !record.project_number.blank?} 
  #end

  #def project_number_form_column(record,input_name)
  #  "<span id='project-number-input'>
  #  #{text_field :record, :project_number, :name => input_name, :class => "project-number" }
 #   </span>"
 # end

end
