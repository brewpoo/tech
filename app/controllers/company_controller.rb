class CompanyController < ApplicationController

  active_scaffold :company do |config|
    list.columns = [:name, :phones, :url, :is_vendor, :is_provider, :is_manufacturer]
    list.sorting = {:name => :asc}
    list.per_page = 50
    show.columns = [:name, :phones, :url, :is_vendor, :is_provider, :is_manufacturer,
      :departments, :purchase_contacts, :bpo, :bpo_expiry, :contacts, :notes]
    columns[:contact].label = "Primary Contact"
    columns[:is_vendor].label = "Vendor?"
    columns[:is_vendor].form_ui = :checkbox
    columns[:is_provider].label = "Provider?"
    columns[:is_provider].form_ui = :checkbox 
    columns[:is_manufacturer].form_ui = :checkbox 
    columns[:is_manufacturer].label = "Manufacturer?"
    update.columns = create.columns = [:name, :phones, :url, :is_vendor, :is_provider, :is_manufacturer, :departments, :bpo, :bpo_expiry, :contacts, :notes]
    nested.add_link('Contacts',[:contacts])
    nested.add_link('Departments',[:departments])
  end

end
