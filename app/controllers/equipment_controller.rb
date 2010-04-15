class EquipmentController < ApplicationController

  active_scaffold :equipment do |config|
    columns.add :product_full_name, :children
    list.columns = [:product_full_name, :device, :role, :location, :equipment_status, :serial_number, :tag_number, :count]
    show.columns = [:product_full_name, :device, :role, :location, :equipment_status, :serial_number, :tag_number, :count]
    create.columns = update.columns = [:product, :device, :role, :location, :serial_number, :tag_number, :host_identifier,
                    :equipment_status, :delivery_date, :count]
    list.sorting = { :device => :asc }
    list.per_page = 50
    columns[:device].sort_by :sql => 'devices.hostname'
    #columns[:device].includes = [:product]
    columns[:product_full_name].label = 'Product'
    columns[:equipment_status].form_ui = :select
    columns[:parent].form_ui = :select
    columns[:product].form_ui = :select
    columns[:location].form_ui = :select
    columns[:role].form_ui  = :select
    subform.columns = [:product, :location, :serial_number, :tag_number, :host_identifier, :equipment_status]
    #columns[:children].association.reverse = :parent
    nested.add_link("Components", [:children])
    nested.add_link("Properties", [:equipment_properties])
    # Searching and sorting
    columns[:role].sort_by :sql => 'roles.name'
    columns[:equipment_status].sort_by :sql => 'equipment_statuses.name'
    columns[:device].sort_by :sql => 'devices.hostname'
    columns[:device].search_sql = 'devices.hostname'
    columns[:product_full_name].search_sql = 'products.full_name'
    columns[:location].search_sql = 'locations.long_name'
    search.columns << [:device, :location, :product_full_name]
    # Filters
    config.actions.add :list_filter
    config.list_filter.add(:association, :role, {:label => "Group", :association => [:role]})
    config.list_filter.add(:association, :equipment_status, {:label => "Status", :association => [ :equipment_status ] })
  
  end

  def conditions_for_collection 
    ['equipment.parent_id IS NULL']
  end

  protected

  def self.active_scaffold_controller_for(klass)
    return ApplicationController::SubEquipmentController if klass == Equipment
    return "#{klass}ScaffoldController".constantize rescue super
  end

end
