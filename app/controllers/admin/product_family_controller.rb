class Admin::ProductFamilyController < Admin::BaseController

  active_scaffold :product_family do |config|
    list.columns = [:manufacturer, :name, :alias]
    update.columns = create.columns = [:manufacturer, :name, :alias]
    nested.add_link("Show Products",[:products])
  end

end
