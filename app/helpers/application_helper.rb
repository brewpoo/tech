# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def calendar_field(record,field_name,calendar_options={})
    calendar_box(:record,field_name,
      { :class => 'date', :button_title => 'Choose',
        :include_blanck => true, :use_month_numbers => true },
      calendar_option_defaults.merge(calendar_options)) rescue
    date_select(:record,field_name,calendar_options)
  end

  def calendar_option_defaults(date=nil)
    options = {
      :firstDay => 1,
      :range => [2000,2020],
      :step => 1,
      :showOthers => true,
      :cache => true }
    options[:date] = date unless date.nil?
    options
  end

  def render_flash
    output = []

    for key,value in flash
      output << "<span class=\"#{key.to_s.downcase}\">#{value}</span>"
    end if flash

    output.join("<br/>\n")
  end

  def render_related_tasks
    options=[]
    options<<["Related Tasks",""]
    task=Task.find(:first,:conditions=>['action=? and controller=?',controller.action_name,'/'+controller.controller_path]) || Task.new
    return nil unless task.related_tasks.length > 0
    task.related_tasks.each do |this|
      options << [this.related_task.title, this.related_task.link] if this_user.match_any_roles?(this.related_task.inherited_roles)
    end if task
    output = select_tag 'related_task', options_for_select(options), :onchange => "location.href=jump.related_task.options[selectedIndex].value"
    return output 
  end


  def add_note_link(name)
    button_to_function name do |page|
      page.insert_html :bottom, :notes, :partial => 'note', :object => Note.new
    end
  end

  def add_contact_link(return_to="",partial="")
    link_to_function image_tag('add.gif'), "new Ajax.Request('/contact/new_contact?employer="+this_user.contact.employer.id.to_s+"&return_to="+return_to+"&partial="+partial+"')"
  end

  def all_locations_link(return_to="",partial="")
    link_to_function image_tag('magnifier.png'), "new Ajax.Request('/location/all_locations?return_to="+return_to+"&partial="+partial+"')"
  end

  def all_products_link(return_to="",partial="")
    link_to_function image_tag('magnifier.png'), "new Ajax.Request('/product/all_products?return_to="+return_to+"&partial="+partial+"')"
  end

  def all_contacts_link(return_to="",partial="")
    link_to_function image_tag('magnifier.png'), "new Ajax.Request('/contact/all_contacts?return_to="+return_to+"&partial="+partial+"')"
  end

  def all_server_devices_link(return_to="",partial="")
    link_to_function image_tag('magnifier.png'), "new Ajax.Request('/device/all_server_devices?return_to="+return_to+"&partial="+partial+"')"
  end

  def all_devices_link(return_to="",partial="")
    link_to_function image_tag('magnifier.png'), "new Ajax.Request('/device/all_devices?return_to="+return_to+"&partial="+partial+"')"
  end



  def add_project_link
    link_to_function image_tag('add.gif'), "new Ajax.Request('/project/new_project')"
  end

  def yesorno(val)
    return "Yes" if val
    return "No"
  end

  def yesonly(val)
    return "Yes" if val
    return ""
  end

  def loading_indicator(id)
   image_tag "indicator.gif", :style => "visibility:hidden;", :id => id, 
    :alt => "loading indicator", :class => "loading-indicator"
  end


end

