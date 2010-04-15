class AddClosedDetailReport < ActiveRecord::Migration
  def self.up
    Task.create(:title => "Reports", :controller => "/admin/report", :action => "list",
      :parent => Task.find_by_title("Manage Data"))
    Task.create(:title => "Orders", :controller => "/report", :action => "order", 
      :parent => Task.find_by_title("Reports"))
    Report.create(:title => "Closed Orders - Detailed", :controller => "order",
      :action => "closed_detail", :filters => "start_date\nend_date\nrequestor\norder_status")
    Report.create(:title => "Order Aging - Detailed", :controller => "order",
      :action => "aging", :filters => "number_days_old\norder_type\nrequestor")
  end

  def self.down
  end
end
