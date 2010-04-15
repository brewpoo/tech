class AddServiceRequestToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :service_request, :string
  end

  def self.down
    remove_column :projects, :service_request
  end
end
