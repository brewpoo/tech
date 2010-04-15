class LocationController < ApplicationController

  active_scaffold :location do |config|
    columns.add :long_name
    list.columns = [:long_name, :nick_name, :contact, :address, :parent]
    list.per_page = 100
    update.columns = create.columns = [:parent, :name, :nick_name, :short_name, 
      :description, :mailstop, :address, :latitude, :longitude, :contact, :is_delivery_location, :is_storage_location]
    show.columns = [:long_name, :name, :short_name, :nick_name, :description, :latitude, :longitude, :address, :mailstop,
      :contact, :equipment, :circuits, :is_storage_location ]
    columns[:parent].form_ui = :select
    columns[:nick_name].inplace_edit=true
    columns[:long_name].sort_by :method => 'long_name'
    columns[:is_delivery_location].label = "Delivery Location?"
    columns[:is_delivery_location].form_ui = :checkbox
    columns[:is_storage_location].label = "Storage Location?"
    columns[:is_storage_location].form_ui = :checkbox
  end

  def merge_locations
    @locations=Location.find(:all).sort_by{|l| l.long_name}.map{|l| ["#{l.long_name} (#{l.used_count})", l.id]}
    if request.post?
      from=Location.find(params[:merge_from][:id].to_i)
      to=Location.find(params[:merge_to][:id].to_i)
      if from.equipment
        from.equipment.each do |e|
          e.location=to
          e.save
        end
      end
      if from.contacts
        from.contacts.each do |c|
          c.location=to
          c.save
        end
      end
      if from.circuits
        from.circuits.each do |c|
          c.location=to
          c.save
        end
      end
      if from.pc01s
        from.pc01s.each do |c|
          c.location=to
          c.save
        end
      end

      from.destroy
      flash[:notice]="Locations have been merged"
      redirect_to :action => 'list' and return
    end
  end


  def all_locations
    return unless request.xhr?
    @locations = Location.select_map
    render_js
  end

end
