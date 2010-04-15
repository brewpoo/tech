class CreateMissingIndexes < ActiveRecord::Migration
  def self.up
    add_index :application_servers, :application_id
    add_index :application_servers, :server_id
    add_index :application_servers, :service_status_id
    add_index :application_servers, :service_id
    add_index :apps, :name
    add_index :apps, :department_id
    add_index :apps, :manager_id
    add_index :apps, :owner_id
    add_index :architectures, :name
    add_index :attachments, :attachable_id
    add_index :attachments, :attachable_type
    add_index :circuit_types, :name
    add_index :companies, :name
    add_index :contacts, :is_manager
    add_index :contacts, :is_engineer
    add_index :devices, :hostname
    add_index :devices, :device_id
    add_index :devices, :primary_engineer_id
    add_index :devices, :operating_system_id
    add_index :devices, :is_san_connected
    add_index :devices, :is_tivoli_agent
    add_index :domain_names, :nameable_id
    add_index :domain_names, :nameable_type
    add_index :domain_names, :domain_id
    add_index :domain_names, :hostname
    add_index :domains, :primary_server_id
    add_index :engineers_projects, :engineer_id
    add_index :engineers_projects, :project_id
    add_index :equipment_properties, :equipment_id
    add_index :equipment_properties, :property_id
    add_index :line_speeds, :name
    add_index :link_categories, :parent_id
    add_index :link_categories, :name
    add_index :links, :linkable_id
    add_index :links, :linkable_type
    add_index :links, :link_category_id
    add_index :operating_systems, :parent_id
    add_index :operating_systems, :name
    add_index :pc01_items, :is_true_up
    add_index :priorities, :name
    add_index :product_properties, :product_id
    add_index :product_properties, :property_id
    add_index :products, :model_number
    add_index :products, :part_number
    add_index :project_statuses, :name
    add_index :project_types, :name
    add_index :project_types, :abbreviation
    add_index :projects, :priority
    add_index :projects, :engineer_id
    add_index :projects, :project_type_id
    add_index :projects, :project_status_id
    add_index :projects, :priority_id
    add_index :properties, :name
    add_index :roles, :flag
    add_index :service_statuses, :name
    add_index :services, :name
    add_index :virtual_host_types, :name
  end

  def self.down
  end
end
