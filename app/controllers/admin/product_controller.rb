class Admin::ProductController < Admin::BaseController

  active_scaffold :product do |config|
    columns.add :manufacturer_name, :product_name
    list.columns = [:manufacturer_name, :product_name, :device_class, :model_number, :part_number]
    update.columns = create.columns = [:product_family, :device_class, :name, :model_number, 
      :part_number, :spare_number, :description, :architecture, :detailed]
    columns[:detailed].form_ui = :checkbox
    columns[:manufacturer_name].sort_by :method => 'product_family.manufacturer.name'
    columns[:product_name].sort_by :method => 'product_family.name'
    nested.add_link("Show Equipment",[:equipment])
  end

end
