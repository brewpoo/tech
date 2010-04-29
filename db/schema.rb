# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100429221423) do

  create_table "addresses", :force => true do |t|
    t.integer "location_id"
    t.string  "street_address"
    t.text    "description"
    t.string  "city"
    t.integer "state_id"
    t.string  "zip"
  end

  add_index "addresses", ["location_id"], :name => "index_addresses_on_location_id"
  add_index "addresses", ["state_id"], :name => "index_addresses_on_state_id"

  create_table "application_servers", :force => true do |t|
    t.integer "application_id"
    t.integer "server_id"
    t.integer "service_status_id"
    t.integer "service_id"
  end

  add_index "application_servers", ["application_id"], :name => "index_application_servers_on_application_id"
  add_index "application_servers", ["server_id"], :name => "index_application_servers_on_server_id"
  add_index "application_servers", ["service_id"], :name => "index_application_servers_on_service_id"
  add_index "application_servers", ["service_status_id"], :name => "index_application_servers_on_service_status_id"

  create_table "apps", :force => true do |t|
    t.string  "name"
    t.string  "short_name"
    t.text    "description"
    t.integer "department_id"
    t.integer "manager_id"
    t.integer "owner_id"
    t.integer "priority_id"
  end

  add_index "apps", ["department_id"], :name => "index_apps_on_department_id"
  add_index "apps", ["manager_id"], :name => "index_apps_on_manager_id"
  add_index "apps", ["name"], :name => "index_apps_on_name"
  add_index "apps", ["owner_id"], :name => "index_apps_on_owner_id"

  create_table "architectures", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "parent_id"
  end

  add_index "architectures", ["name"], :name => "index_architectures_on_name"
  add_index "architectures", ["parent_id"], :name => "index_architectures_on_parent_id"

  create_table "attachments", :force => true do |t|
    t.string   "filename"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "content_type"
    t.binary   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  add_index "attachments", ["attachable_id"], :name => "index_attachments_on_attachable_id"
  add_index "attachments", ["attachable_type"], :name => "index_attachments_on_attachable_type"

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "changes"
    t.integer  "version",        :default => 0
    t.datetime "created_at"
  end

  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "circuit_types", :force => true do |t|
    t.string  "name"
    t.string  "flag"
    t.text    "description"
    t.integer "old_application_id"
  end

  add_index "circuit_types", ["name"], :name => "index_circuit_types_on_name"

  create_table "circuits", :force => true do |t|
    t.integer "parent_id"
    t.integer "next_id"
    t.integer "provider_id"
    t.integer "line_speed_id"
    t.string  "circuit_number"
    t.text    "description"
    t.date    "date_installed"
    t.boolean "is_disconnected"
    t.date    "date_disconnected"
    t.integer "circuit_type_id"
    t.integer "line_type_id"
    t.integer "old_circuit_id"
  end

  add_index "circuits", ["circuit_number"], :name => "index_circuits_on_circuit_number"
  add_index "circuits", ["circuit_type_id"], :name => "index_circuits_on_circuit_type_id"
  add_index "circuits", ["is_disconnected"], :name => "index_circuits_on_is_disconnected"
  add_index "circuits", ["line_speed_id"], :name => "index_circuits_on_line_speed_id"
  add_index "circuits", ["line_type_id"], :name => "index_circuits_on_line_type_id"
  add_index "circuits", ["next_id"], :name => "index_circuits_on_next_id"
  add_index "circuits", ["parent_id"], :name => "index_circuits_on_parent_id"
  add_index "circuits", ["provider_id"], :name => "index_circuits_on_provider_id"

  create_table "circuits_locations", :id => false, :force => true do |t|
    t.integer "location_id"
    t.integer "circuit_id"
  end

  add_index "circuits_locations", ["circuit_id"], :name => "index_circuits_locations_on_circuit_id"
  add_index "circuits_locations", ["location_id"], :name => "index_circuits_locations_on_location_id"

  create_table "cities", :force => true do |t|
    t.string  "name"
    t.integer "state_id"
    t.string  "po_city"
    t.string  "po_zip"
  end

  add_index "cities", ["name"], :name => "index_cities_on_name"
  add_index "cities", ["po_zip"], :name => "index_cities_on_po_zip"
  add_index "cities", ["state_id"], :name => "index_cities_on_state_id"

  create_table "companies", :force => true do |t|
    t.string  "name"
    t.boolean "is_vendor"
    t.integer "contact_id"
    t.boolean "is_provider"
    t.boolean "is_manufacturer"
    t.string  "url"
    t.string  "bpo"
    t.date    "bpo_expiry"
  end

  add_index "companies", ["contact_id"], :name => "index_companies_on_contact_id"
  add_index "companies", ["is_manufacturer"], :name => "index_companies_on_is_manufacturer"
  add_index "companies", ["is_provider"], :name => "index_companies_on_is_provider"
  add_index "companies", ["is_vendor"], :name => "index_companies_on_is_vendor"
  add_index "companies", ["name"], :name => "index_companies_on_name"

  create_table "components", :force => true do |t|
    t.integer "parent_id"
    t.boolean "is_base"
  end

  add_index "components", ["parent_id"], :name => "index_components_on_parent_id"

  create_table "contacts", :force => true do |t|
    t.string  "last_name"
    t.string  "first_name"
    t.integer "department_id"
    t.integer "location_id"
    t.string  "employee_number"
    t.string  "email"
    t.integer "manager_id"
    t.text    "description"
    t.integer "employer_id"
    t.string  "title"
    t.boolean "is_purchase_contact"
    t.integer "fund_code"
    t.integer "management_center"
    t.string  "work_order"
    t.integer "budget_code"
    t.boolean "is_manager"
    t.boolean "is_engineer"
  end

  add_index "contacts", ["department_id"], :name => "index_contacts_on_department_id"
  add_index "contacts", ["employee_number"], :name => "index_contacts_on_employee_number", :unique => true
  add_index "contacts", ["employer_id"], :name => "index_contacts_on_employer_id"
  add_index "contacts", ["is_engineer"], :name => "index_contacts_on_is_engineer"
  add_index "contacts", ["is_manager"], :name => "index_contacts_on_is_manager"
  add_index "contacts", ["is_purchase_contact"], :name => "index_contacts_on_is_purchase_contact"
  add_index "contacts", ["last_name", "first_name"], :name => "full_name_index"
  add_index "contacts", ["location_id"], :name => "index_contacts_on_location_id"
  add_index "contacts", ["manager_id"], :name => "index_contacts_on_manager_id"

  create_table "departments", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.string  "alternate_name"
    t.integer "parent_id"
    t.integer "company_id"
  end

  add_index "departments", ["company_id"], :name => "index_departments_on_company_id"
  add_index "departments", ["name"], :name => "index_departments_on_name"
  add_index "departments", ["parent_id"], :name => "index_departments_on_parent_id"

  create_table "device_classes", :force => true do |t|
    t.integer "parent_id"
    t.string  "name"
    t.text    "description"
    t.integer "old_hostclass_id"
    t.string  "set_type"
  end

  add_index "device_classes", ["name"], :name => "index_device_classes_on_name"
  add_index "device_classes", ["parent_id"], :name => "index_device_classes_on_parent_id"

  create_table "devices", :force => true do |t|
    t.integer "device_class_id"
    t.integer "equipment_id"
    t.integer "contact_id"
    t.string  "hostname"
    t.text    "description"
    t.boolean "is_virtual"
    t.boolean "is_dummy"
    t.integer "domain_id"
    t.integer "primary_interface_id"
    t.integer "device_id"
    t.string  "type"
    t.integer "primary_engineer_id"
    t.boolean "is_san_connected"
    t.boolean "is_tivoli_agent"
    t.integer "operating_system_id"
  end

  add_index "devices", ["contact_id"], :name => "index_devices_on_contact_id"
  add_index "devices", ["device_class_id"], :name => "index_devices_on_device_class_id"
  add_index "devices", ["device_id"], :name => "index_devices_on_device_id"
  add_index "devices", ["domain_id"], :name => "index_devices_on_domain_id"
  add_index "devices", ["equipment_id"], :name => "index_devices_on_equipment_id"
  add_index "devices", ["hostname"], :name => "index_devices_on_hostname"
  add_index "devices", ["is_dummy"], :name => "index_devices_on_is_dummy"
  add_index "devices", ["is_san_connected"], :name => "index_devices_on_is_san_connected"
  add_index "devices", ["is_tivoli_agent"], :name => "index_devices_on_is_tivoli_agent"
  add_index "devices", ["is_virtual"], :name => "index_devices_on_is_virtual"
  add_index "devices", ["operating_system_id"], :name => "index_devices_on_operating_system_id"
  add_index "devices", ["primary_engineer_id"], :name => "index_devices_on_primary_engineer_id"
  add_index "devices", ["primary_interface_id"], :name => "index_devices_on_primary_interface_id"

  create_table "dial_lines", :force => true do |t|
    t.integer "device_id"
    t.integer "circuit_id"
    t.text    "description"
  end

  add_index "dial_lines", ["circuit_id"], :name => "index_dial_lines_on_circuit_id"
  add_index "dial_lines", ["device_id"], :name => "index_dial_lines_on_device_id"

  create_table "distributed_items", :force => true do |t|
    t.date    "distributed_on"
    t.integer "contact_id"
    t.integer "order_item_id"
    t.integer "quantity"
    t.integer "processor_id"
  end

  add_index "distributed_items", ["contact_id"], :name => "index_distributed_items_on_contact_id"
  add_index "distributed_items", ["distributed_on"], :name => "index_distributed_items_on_distributed_on"
  add_index "distributed_items", ["order_item_id"], :name => "index_distributed_items_on_order_item_id"
  add_index "distributed_items", ["processor_id"], :name => "index_distributed_items_on_processor_id"

  create_table "domain_names", :force => true do |t|
    t.integer "nameable_id"
    t.string  "nameable_type"
    t.string  "hostname"
    t.integer "domain_id"
    t.boolean "publish_reverse"
    t.date    "created_on"
    t.date    "updated_on"
  end

  add_index "domain_names", ["domain_id"], :name => "index_domain_names_on_domain_id"
  add_index "domain_names", ["hostname"], :name => "index_domain_names_on_hostname"
  add_index "domain_names", ["nameable_id"], :name => "index_domain_names_on_nameable_id"
  add_index "domain_names", ["nameable_type"], :name => "index_domain_names_on_nameable_type"

  create_table "domains", :force => true do |t|
    t.integer "parent_id"
    t.string  "name"
    t.text    "description"
    t.boolean "autodns"
    t.integer "maintainer_id"
    t.integer "primary_server_id"
    t.boolean "generate_soa"
    t.string  "soa_timer_section"
  end

  add_index "domains", ["autodns"], :name => "index_domains_on_autodns"
  add_index "domains", ["maintainer_id"], :name => "index_domains_on_maintainer_id"
  add_index "domains", ["name"], :name => "index_domains_on_name"
  add_index "domains", ["parent_id"], :name => "index_domains_on_parent_id"
  add_index "domains", ["primary_server_id"], :name => "index_domains_on_primary_server_id"

  create_table "domains_servers", :id => false, :force => true do |t|
    t.integer "domain_id"
    t.integer "server_id"
  end

  add_index "domains_servers", ["domain_id"], :name => "index_domains_servers_on_domain_id"
  add_index "domains_servers", ["server_id"], :name => "index_domains_servers_on_server_id"

  create_table "engineers_projects", :id => false, :force => true do |t|
    t.integer "engineer_id"
    t.integer "project_id"
  end

  add_index "engineers_projects", ["engineer_id"], :name => "index_engineers_projects_on_engineer_id"
  add_index "engineers_projects", ["project_id"], :name => "index_engineers_projects_on_project_id"

  create_table "equipment", :force => true do |t|
    t.integer "product_id"
    t.integer "parent_id"
    t.date    "delivery_date"
    t.integer "location_id"
    t.string  "tag_number"
    t.string  "serial_number"
    t.string  "host_identifier"
    t.integer "status_id"
    t.integer "count"
    t.integer "equipment_status_id"
    t.date    "warranty_expiry"
    t.integer "role_id"
  end

  add_index "equipment", ["count"], :name => "index_equipment_on_count"
  add_index "equipment", ["equipment_status_id"], :name => "index_equipment_on_equipment_status_id"
  add_index "equipment", ["location_id"], :name => "index_equipment_on_location_id"
  add_index "equipment", ["parent_id"], :name => "index_equipment_on_parent_id"
  add_index "equipment", ["product_id"], :name => "index_equipment_on_product_id"
  add_index "equipment", ["role_id"], :name => "index_equipment_on_role_id"
  add_index "equipment", ["serial_number"], :name => "index_equipment_on_serial_number"
  add_index "equipment", ["status_id"], :name => "index_equipment_on_status_id"

  create_table "equipment_properties", :force => true do |t|
    t.integer "equipment_id"
    t.integer "property_id"
    t.string  "value"
  end

  add_index "equipment_properties", ["equipment_id"], :name => "index_equipment_properties_on_equipment_id"
  add_index "equipment_properties", ["property_id"], :name => "index_equipment_properties_on_property_id"

  create_table "equipment_statuses", :force => true do |t|
    t.string "name"
    t.text   "description"
    t.string "flag"
  end

  add_index "equipment_statuses", ["name"], :name => "index_equipment_statuses_on_name"

  create_table "interfaces", :force => true do |t|
    t.integer "device_id"
    t.string  "hardware_address"
    t.string  "name"
    t.boolean "is_dynamic"
    t.integer "topology_id"
    t.integer "vlanid"
    t.boolean "is_wireless"
  end

  add_index "interfaces", ["device_id"], :name => "index_interfaces_on_device_id"
  add_index "interfaces", ["hardware_address"], :name => "index_interfaces_on_hardware_address"
  add_index "interfaces", ["is_wireless"], :name => "index_interfaces_on_is_wireless"
  add_index "interfaces", ["topology_id"], :name => "index_interfaces_on_topology_id"

  create_table "ipv4_address_holds", :force => true do |t|
    t.integer  "ipv4_subnet_id"
    t.integer  "ip_address_packed", :limit => 8
    t.datetime "held_on"
  end

  add_index "ipv4_address_holds", ["held_on"], :name => "index_ipv4_address_holds_on_held_on"
  add_index "ipv4_address_holds", ["ip_address_packed"], :name => "index_ipv4_address_holds_on_ip_address_packed"
  add_index "ipv4_address_holds", ["ipv4_subnet_id"], :name => "index_ipv4_address_holds_on_ipv4_subnet_id"

  create_table "ipv4_address_ranges", :force => true do |t|
    t.integer "zone_id"
    t.integer "ipv4_scope_id"
    t.boolean "is_dynamic"
    t.boolean "is_reserved"
    t.string  "start_address"
    t.integer "start_address_packed", :limit => 8
    t.string  "end_address"
    t.integer "end_address_packed",   :limit => 8
  end

  add_index "ipv4_address_ranges", ["ipv4_scope_id"], :name => "index_ipv4_address_ranges_on_ipv4_scope_id"
  add_index "ipv4_address_ranges", ["zone_id"], :name => "index_ipv4_address_ranges_on_zone_id"

  create_table "ipv4_assigned_networks", :force => true do |t|
    t.string  "subnet_address"
    t.integer "subnet_address_packed", :limit => 8
    t.integer "prefix"
    t.text    "description"
  end

  create_table "ipv4_assignments", :force => true do |t|
    t.integer "zone_id"
    t.integer "prefix"
    t.integer "network_class_id"
    t.integer "topology_id"
    t.integer "assign_prefix"
    t.text    "description"
    t.string  "subnet_address"
    t.integer "subnet_address_packed", :limit => 8
  end

  add_index "ipv4_assignments", ["network_class_id"], :name => "index_ipv4_assignments_on_network_class_id"
  add_index "ipv4_assignments", ["topology_id"], :name => "index_ipv4_assignments_on_topology_id"
  add_index "ipv4_assignments", ["zone_id"], :name => "index_ipv4_assignments_on_zone_id"

  create_table "ipv4_interfaces", :force => true do |t|
    t.integer  "ipv4_subnet_id"
    t.integer  "interface_id"
    t.boolean  "is_reserved"
    t.boolean  "is_delinquent"
    t.boolean  "is_stealth"
    t.boolean  "is_rogue"
    t.boolean  "is_virtual"
    t.string   "ip_address"
    t.integer  "ip_address_packed", :limit => 8
    t.integer  "old_interface_id"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer  "ping_count"
    t.datetime "last_pinged_on"
  end

  add_index "ipv4_interfaces", ["interface_id"], :name => "index_ipv4_interfaces_on_interface_id"
  add_index "ipv4_interfaces", ["ip_address_packed"], :name => "index_ipv4_interfaces_on_ip_address_packed"
  add_index "ipv4_interfaces", ["ipv4_subnet_id"], :name => "index_ipv4_interfaces_on_ipv4_subnet_id"

  create_table "ipv4_networks", :force => true do |t|
    t.integer "network_address"
    t.integer "network_mask"
    t.text    "description"
  end

  create_table "ipv4_schema_rules", :force => true do |t|
    t.integer "zone_id"
    t.integer "network_address_packed", :limit => 8
    t.integer "network_mask_packed",    :limit => 8
    t.integer "device_class_id"
    t.integer "lbound"
    t.integer "ubound"
    t.text    "description"
    t.string  "network_address"
    t.string  "network_mask"
  end

  add_index "ipv4_schema_rules", ["device_class_id"], :name => "index_ipv4_schema_rules_on_device_class_id"
  add_index "ipv4_schema_rules", ["zone_id"], :name => "index_ipv4_schema_rules_on_zone_id"

  create_table "ipv4_scope_option_entries", :force => true do |t|
    t.integer "ipv4_scope_id"
    t.integer "ipv4_scope_option_id"
    t.string  "value"
  end

  add_index "ipv4_scope_option_entries", ["ipv4_scope_id"], :name => "index_ipv4_scope_option_entries_on_ipv4_scope_id"
  add_index "ipv4_scope_option_entries", ["ipv4_scope_option_id"], :name => "index_ipv4_scope_option_entries_on_ipv4_scope_option_id"

  create_table "ipv4_scope_options", :force => true do |t|
    t.string "name"
    t.text   "description"
    t.string "value"
  end

  create_table "ipv4_scopes", :force => true do |t|
    t.integer "ipv4_subnet_id"
    t.string  "name"
    t.text    "description"
    t.integer "server_id"
    t.integer "gateway_id"
  end

  add_index "ipv4_scopes", ["gateway_id"], :name => "index_ipv4_scopes_on_gateway_id"
  add_index "ipv4_scopes", ["ipv4_subnet_id"], :name => "index_ipv4_scopes_on_ipv4_subnet_id"
  add_index "ipv4_scopes", ["server_id"], :name => "index_ipv4_scopes_on_server_id"

  create_table "ipv4_subnets", :force => true do |t|
    t.integer "subnet_id"
    t.integer "parent_id"
    t.integer "zone_id"
    t.string  "subnet_address"
    t.integer "subnet_address_packed", :limit => 8
    t.string  "subnet_mask"
    t.integer "subnet_mask_packed",    :limit => 8
    t.text    "description"
    t.integer "old_network_id"
    t.string  "gateway_address"
  end

  add_index "ipv4_subnets", ["parent_id"], :name => "index_ipv4_subnets_on_parent_id"
  add_index "ipv4_subnets", ["subnet_address_packed"], :name => "index_ipv4_subnets_on_subnet_address_packed"
  add_index "ipv4_subnets", ["subnet_id"], :name => "index_ipv4_subnets_on_subnet_id"
  add_index "ipv4_subnets", ["subnet_mask_packed"], :name => "index_ipv4_subnets_on_subnet_mask_packed"
  add_index "ipv4_subnets", ["zone_id"], :name => "index_ipv4_subnets_on_zone_id"

  create_table "ipv4_virtual_host_interfaces", :force => true do |t|
    t.integer "ipv4_virtual_host_id"
    t.integer "ipv4_interface_id"
    t.integer "priority"
  end

  add_index "ipv4_virtual_host_interfaces", ["ipv4_interface_id"], :name => "index_ipv4_virtual_host_interfaces_on_ipv4_interface_id"
  add_index "ipv4_virtual_host_interfaces", ["ipv4_virtual_host_id"], :name => "index_ipv4_virtual_host_interfaces_on_ipv4_virtual_host_id"

  create_table "ipv4_virtual_hosts", :force => true do |t|
    t.integer "ipv4_subnet_id"
    t.integer "vrid"
    t.text    "description"
    t.integer "ipv4_interface_id"
    t.boolean "is_vrrp"
    t.integer "old_virtual_id"
    t.integer "virtual_host_type_id"
    t.integer "otherid"
  end

  add_index "ipv4_virtual_hosts", ["ipv4_interface_id"], :name => "index_ipv4_virtual_hosts_on_ipv4_interface_id"
  add_index "ipv4_virtual_hosts", ["ipv4_subnet_id"], :name => "index_ipv4_virtual_hosts_on_ipv4_subnet_id"
  add_index "ipv4_virtual_hosts", ["virtual_host_type_id"], :name => "index_ipv4_virtual_hosts_on_virtual_host_type_id"

  create_table "line_speeds", :force => true do |t|
    t.integer "topology_id"
    t.integer "parent_id"
    t.string  "name"
    t.string  "speed"
    t.integer "old_linespeed_id"
  end

  add_index "line_speeds", ["name"], :name => "index_line_speeds_on_name"
  add_index "line_speeds", ["parent_id"], :name => "index_line_speeds_on_parent_id"
  add_index "line_speeds", ["topology_id"], :name => "index_line_speeds_on_topology_id"

  create_table "line_types", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "parent_id"
    t.integer "old_channel_id"
  end

  add_index "line_types", ["name"], :name => "index_line_types_on_name"
  add_index "line_types", ["parent_id"], :name => "index_line_types_on_parent_id"

  create_table "link_categories", :force => true do |t|
    t.integer "parent_id"
    t.string  "name"
    t.text    "description"
  end

  add_index "link_categories", ["name"], :name => "index_link_categories_on_name"
  add_index "link_categories", ["parent_id"], :name => "index_link_categories_on_parent_id"

  create_table "links", :force => true do |t|
    t.integer "linkable_id"
    t.string  "linkable_type"
    t.integer "link_category_id"
    t.string  "url"
    t.string  "title"
  end

  add_index "links", ["link_category_id"], :name => "index_links_on_link_category_id"
  add_index "links", ["linkable_id"], :name => "index_links_on_linkable_id"
  add_index "links", ["linkable_type"], :name => "index_links_on_linkable_type"

  create_table "locations", :force => true do |t|
    t.integer "parent_id"
    t.string  "name"
    t.integer "depth"
    t.text    "description"
    t.integer "contact_id"
    t.string  "nick_name"
    t.string  "short_name"
    t.string  "mailstop"
    t.decimal "latitude",             :precision => 15, :scale => 10
    t.decimal "longitude",            :precision => 15, :scale => 10
    t.boolean "is_delivery_location"
    t.integer "old_id"
    t.string  "long_name"
    t.boolean "is_storage_location"
    t.boolean "is_data_center"
  end

  add_index "locations", ["contact_id"], :name => "index_locations_on_contact_id"
  add_index "locations", ["depth"], :name => "index_locations_on_depth"
  add_index "locations", ["is_data_center"], :name => "index_locations_on_is_data_center"
  add_index "locations", ["is_delivery_location"], :name => "index_locations_on_is_delivery_location"
  add_index "locations", ["is_storage_location"], :name => "index_locations_on_is_storage_location"
  add_index "locations", ["long_name"], :name => "index_locations_on_long_name"
  add_index "locations", ["name"], :name => "index_locations_on_name"
  add_index "locations", ["parent_id"], :name => "index_locations_on_parent_id"

  create_table "maintenance_logs", :force => true do |t|
    t.integer  "loggable_id"
    t.string   "loggable_type"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string   "created_by"
    t.string   "title"
    t.text     "body"
  end

  add_index "maintenance_logs", ["created_on"], :name => "index_maintenance_logs_on_created_on"
  add_index "maintenance_logs", ["loggable_id"], :name => "index_maintenance_logs_on_loggable_id"
  add_index "maintenance_logs", ["loggable_type"], :name => "index_maintenance_logs_on_loggable_type"

  create_table "mp_dlcis", :force => true do |t|
    t.integer "dlci"
    t.integer "mp_line_id"
    t.integer "interface_id"
    t.integer "old_dlci_id"
  end

  add_index "mp_dlcis", ["interface_id"], :name => "index_mp_dlcis_on_interface_id"
  add_index "mp_dlcis", ["mp_line_id"], :name => "index_mp_dlcis_on_mp_line_id"

  create_table "mp_lines", :force => true do |t|
    t.integer "device_id"
    t.integer "circuit_id"
    t.integer "old_mp_line_id"
  end

  add_index "mp_lines", ["circuit_id"], :name => "index_mp_lines_on_circuit_id"
  add_index "mp_lines", ["device_id"], :name => "index_mp_lines_on_device_id"

  create_table "mp_pvcs", :force => true do |t|
    t.integer "dlci_a_id"
    t.integer "dlci_b_id"
    t.integer "old_pvc_id"
  end

  add_index "mp_pvcs", ["dlci_a_id"], :name => "index_mp_pvcs_on_dlci_a_id"
  add_index "mp_pvcs", ["dlci_b_id"], :name => "index_mp_pvcs_on_dlci_b_id"

  create_table "network_classes", :force => true do |t|
    t.integer "parent_id"
    t.string  "name"
    t.text    "description"
    t.integer "old_netclass_id"
  end

  add_index "network_classes", ["name"], :name => "index_network_classes_on_name"
  add_index "network_classes", ["parent_id"], :name => "index_network_classes_on_parent_id"

  create_table "notes", :force => true do |t|
    t.text     "body"
    t.integer  "notable_id"
    t.string   "notable_type"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string   "created_by"
  end

  add_index "notes", ["notable_id", "notable_type"], :name => "notable_index"

  create_table "operating_systems", :force => true do |t|
    t.integer "parent_id"
    t.string  "name"
    t.string  "long_name"
    t.text    "description"
  end

  add_index "operating_systems", ["name"], :name => "index_operating_systems_on_name"
  add_index "operating_systems", ["parent_id"], :name => "index_operating_systems_on_parent_id"

  create_table "order_items", :force => true do |t|
    t.integer "product_id"
    t.integer "quantity"
    t.decimal "unit_price",     :precision => 10, :scale => 2
    t.boolean "can_substitute"
    t.integer "order_id"
    t.text    "details"
  end

  add_index "order_items", ["order_id"], :name => "index_order_items_on_order_id"
  add_index "order_items", ["product_id"], :name => "index_order_items_on_product_id"
  add_index "order_items", ["quantity"], :name => "index_order_items_on_quantity"

  create_table "order_statuses", :force => true do |t|
    t.string  "name"
    t.integer "value"
  end

  add_index "order_statuses", ["name"], :name => "index_order_statuses_on_name"

  create_table "order_types", :force => true do |t|
    t.string  "name"
    t.integer "processor_id"
  end

  add_index "order_types", ["name"], :name => "index_order_types_on_name"
  add_index "order_types", ["processor_id"], :name => "index_order_types_on_processor_id"

  create_table "orders", :force => true do |t|
    t.integer "order_number"
    t.date    "ordered_on"
    t.text    "description"
    t.integer "priority"
    t.integer "order_status_old"
    t.integer "requestor_id"
    t.boolean "is_approved"
    t.string  "approved_by"
    t.date    "approved_on"
    t.integer "order_type_old"
    t.string  "other_order_number"
    t.text    "justification"
    t.integer "department_id"
    t.text    "assignee"
    t.string  "related_pc01"
    t.string  "department_control_number"
    t.string  "old_project"
    t.string  "hwdl"
    t.string  "hw"
    t.integer "order_type_id"
    t.integer "manager_id"
    t.integer "project_id"
    t.string  "service_request"
    t.string  "management_center"
    t.integer "pc01_id"
    t.date    "closed_on"
    t.integer "order_status_id"
    t.integer "budget_year"
    t.integer "fund_code"
    t.string  "work_order"
    t.integer "budget_code"
  end

  add_index "orders", ["closed_on"], :name => "index_orders_on_closed_on"
  add_index "orders", ["department_id"], :name => "index_orders_on_department_id"
  add_index "orders", ["is_approved"], :name => "index_orders_on_is_approved"
  add_index "orders", ["manager_id"], :name => "index_orders_on_manager_id"
  add_index "orders", ["order_number"], :name => "index_orders_on_order_number"
  add_index "orders", ["order_status_id"], :name => "index_orders_on_order_status_id"
  add_index "orders", ["order_type_id"], :name => "index_orders_on_order_type_id"
  add_index "orders", ["ordered_on"], :name => "index_orders_on_ordered_on"
  add_index "orders", ["pc01_id"], :name => "index_orders_on_pc01_id"
  add_index "orders", ["project_id"], :name => "index_orders_on_project_id"
  add_index "orders", ["requestor_id"], :name => "index_orders_on_requestor_id"

  create_table "pc01_categories", :force => true do |t|
    t.string  "title"
    t.text    "description"
    t.integer "order_type_id"
  end

  add_index "pc01_categories", ["title"], :name => "index_pc01_categories_on_title"

  create_table "pc01_items", :force => true do |t|
    t.integer "pc01_id"
    t.integer "pc01_category_id"
    t.text    "description"
    t.boolean "is_stock_item"
    t.boolean "is_fullfilled"
    t.boolean "is_replenished"
    t.integer "quantity"
    t.boolean "is_charge_back"
    t.date    "replenished_on"
    t.decimal "charge_back_amount", :precision => 10, :scale => 2
    t.boolean "is_true_up"
  end

  add_index "pc01_items", ["is_charge_back"], :name => "index_pc01_items_on_is_charge_back"
  add_index "pc01_items", ["is_fullfilled"], :name => "index_pc01_items_on_is_fullfilled"
  add_index "pc01_items", ["is_replenished"], :name => "index_pc01_items_on_is_replenished"
  add_index "pc01_items", ["is_stock_item"], :name => "index_pc01_items_on_is_stock_item"
  add_index "pc01_items", ["is_true_up"], :name => "index_pc01_items_on_is_true_up"
  add_index "pc01_items", ["pc01_category_id"], :name => "index_pc01_items_on_pc01_category_id"
  add_index "pc01_items", ["pc01_id"], :name => "index_pc01_items_on_pc01_id"

  create_table "pc01s", :force => true do |t|
    t.integer  "pc01_number"
    t.date     "pc01_dated"
    t.date     "received_on"
    t.date     "approved_on"
    t.integer  "approved_by"
    t.string   "service_request"
    t.integer  "submitted_by"
    t.integer  "location_id"
    t.text     "description"
    t.string   "management_center"
    t.boolean  "is_completed"
    t.datetime "created_on"
    t.integer  "department_id"
    t.text     "assigned_users"
    t.integer  "budget_year"
    t.integer  "fund_code"
    t.string   "work_order"
    t.integer  "budget_code"
  end

  add_index "pc01s", ["approved_on"], :name => "index_pc01s_on_approved_on"
  add_index "pc01s", ["department_id"], :name => "index_pc01s_on_department_id"
  add_index "pc01s", ["location_id"], :name => "index_pc01s_on_location_id"
  add_index "pc01s", ["pc01_number"], :name => "index_pc01s_on_pc01_number"
  add_index "pc01s", ["received_on"], :name => "index_pc01s_on_received_on"
  add_index "pc01s", ["submitted_by"], :name => "index_pc01s_on_submitted_by"

  create_table "phone_types", :force => true do |t|
    t.string "phone_type"
  end

  add_index "phone_types", ["phone_type"], :name => "index_phone_types_on_phone_type"

  create_table "phones", :force => true do |t|
    t.string  "number"
    t.integer "phone_type_id"
    t.integer "phonable_id"
    t.string  "phonable_type"
    t.text    "description"
  end

  add_index "phones", ["phonable_id", "phonable_type"], :name => "phonable_index"
  add_index "phones", ["phone_type_id"], :name => "index_phones_on_phone_type_id"

  create_table "pp_lines", :force => true do |t|
    t.integer "circuit_id"
    t.integer "subnet_id"
    t.integer "map_reference"
  end

  add_index "pp_lines", ["circuit_id"], :name => "index_pp_lines_on_circuit_id"
  add_index "pp_lines", ["map_reference"], :name => "index_pp_lines_on_map_reference"
  add_index "pp_lines", ["subnet_id"], :name => "index_pp_lines_on_subnet_id"

  create_table "print_daemon_types", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "print_daemons", :force => true do |t|
    t.integer "print_daemon_type_id"
    t.integer "server_id"
    t.integer "printer_id"
    t.string  "name"
  end

  add_index "print_daemons", ["print_daemon_type_id"], :name => "index_print_daemons_on_print_daemon_type_id"
  add_index "print_daemons", ["printer_id"], :name => "index_print_daemons_on_printer_id"
  add_index "print_daemons", ["server_id"], :name => "index_print_daemons_on_server_id"

  create_table "priorities", :force => true do |t|
    t.string  "name"
    t.integer "value"
  end

  add_index "priorities", ["name"], :name => "index_priorities_on_name"

  create_table "product_families", :force => true do |t|
    t.integer "manufacturer_id"
    t.string  "name"
    t.string  "alias"
  end

  add_index "product_families", ["manufacturer_id"], :name => "index_product_families_on_vendor_id"
  add_index "product_families", ["name"], :name => "index_product_families_on_name"

  create_table "product_properties", :force => true do |t|
    t.integer "product_id"
    t.integer "property_id"
  end

  add_index "product_properties", ["product_id"], :name => "index_product_properties_on_product_id"
  add_index "product_properties", ["property_id"], :name => "index_product_properties_on_property_id"

  create_table "products", :force => true do |t|
    t.integer "device_class_id"
    t.integer "architecture_id"
    t.string  "model_number"
    t.string  "part_number"
    t.string  "spare_number"
    t.text    "description"
    t.boolean "detailed"
    t.string  "name"
    t.integer "product_family_id"
    t.text    "full_name"
    t.integer "power_consumption"
    t.integer "heat_output"
  end

  add_index "products", ["architecture_id"], :name => "index_products_on_architecture_id"
  add_index "products", ["detailed"], :name => "index_products_on_detailed"
  add_index "products", ["device_class_id"], :name => "index_products_on_device_class_id"
  add_index "products", ["model_number"], :name => "index_products_on_model_number"
  add_index "products", ["name"], :name => "index_products_on_name"
  add_index "products", ["part_number"], :name => "index_products_on_part_number"
  add_index "products", ["product_family_id"], :name => "index_products_on_product_family_id"

  create_table "project_statuses", :force => true do |t|
    t.string  "name"
    t.integer "value"
  end

  add_index "project_statuses", ["name"], :name => "index_project_statuses_on_name"

  create_table "project_types", :force => true do |t|
    t.string "name"
    t.string "description"
    t.string "abbreviation"
  end

  add_index "project_types", ["abbreviation"], :name => "index_project_types_on_abbreviation"
  add_index "project_types", ["name"], :name => "index_project_types_on_name"

  create_table "project_updates", :force => true do |t|
    t.integer  "project_id"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string   "created_by"
    t.text     "body"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "comments"
    t.string   "created_by"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.integer  "project_number"
    t.integer  "project_status"
    t.integer  "manager_id"
    t.integer  "department_id"
    t.integer  "requestor_id"
    t.integer  "priority"
    t.date     "started_on"
    t.date     "completed_on"
    t.string   "estimated_completion"
    t.integer  "lead_engineer_id"
    t.integer  "project_type_id"
    t.integer  "project_status_id"
    t.integer  "priority_id"
    t.date     "requested_on"
    t.string   "old_project_number"
    t.string   "service_request"
  end

  add_index "projects", ["department_id"], :name => "index_projects_on_department_id"
  add_index "projects", ["lead_engineer_id"], :name => "index_projects_on_engineer_id"
  add_index "projects", ["manager_id"], :name => "index_projects_on_manager_id"
  add_index "projects", ["priority"], :name => "index_projects_on_priority"
  add_index "projects", ["priority_id"], :name => "index_projects_on_priority_id"
  add_index "projects", ["project_status_id"], :name => "index_projects_on_project_status_id"
  add_index "projects", ["project_type_id"], :name => "index_projects_on_project_type_id"
  add_index "projects", ["requestor_id"], :name => "index_projects_on_requestor_id"
  add_index "projects", ["title"], :name => "index_projects_on_title"

  create_table "properties", :force => true do |t|
    t.string "name"
    t.string "unit"
  end

  add_index "properties", ["name"], :name => "index_properties_on_name"

  create_table "received_items", :force => true do |t|
    t.datetime "received_on"
    t.integer  "receiver_id"
    t.integer  "requisition_item_id"
    t.integer  "quantity"
  end

  add_index "received_items", ["received_on"], :name => "index_received_items_on_received_on"
  add_index "received_items", ["receiver_id"], :name => "index_received_items_on_receiver_id"
  add_index "received_items", ["requisition_item_id"], :name => "index_received_items_on_requisition_item_id"

  create_table "related_tasks", :force => true do |t|
    t.integer "task_id"
    t.integer "related_task_id"
  end

  add_index "related_tasks", ["related_task_id"], :name => "index_related_tasks_on_related_task_id"
  add_index "related_tasks", ["task_id"], :name => "index_related_tasks_on_task_id"

  create_table "reports", :force => true do |t|
    t.string "title"
    t.text   "description"
    t.string "model"
    t.text   "filters"
    t.string "action"
    t.string "controller"
  end

  add_index "reports", ["action"], :name => "index_reports_on_action"
  add_index "reports", ["controller"], :name => "index_reports_on_controller"
  add_index "reports", ["title"], :name => "index_reports_on_title"

  create_table "requisition_items", :force => true do |t|
    t.integer "requisition_id"
    t.integer "order_item_id"
    t.integer "quantity"
    t.decimal "unit_price",     :precision => 10, :scale => 2
    t.text    "details"
  end

  add_index "requisition_items", ["order_item_id"], :name => "index_requisition_items_on_order_item_id"
  add_index "requisition_items", ["quantity"], :name => "index_requisition_items_on_quantity"
  add_index "requisition_items", ["requisition_id"], :name => "index_requisition_items_on_requisition_id"

  create_table "requisition_statuses", :force => true do |t|
    t.string  "name"
    t.integer "value"
  end

  add_index "requisition_statuses", ["name"], :name => "index_requisition_statuses_on_name"

  create_table "requisitions", :force => true do |t|
    t.date     "requisitioned_on"
    t.string   "requisition_number"
    t.string   "purchase_order"
    t.integer  "vendor_id"
    t.integer  "requisition_status_old"
    t.integer  "processor_id"
    t.date     "purchased_on"
    t.date     "created_on"
    t.boolean  "sent_emails"
    t.date     "awarded_on"
    t.string   "management_center"
    t.string   "budget_account"
    t.string   "price_quote_number"
    t.datetime "due_by"
    t.date     "deliver_by"
    t.string   "release_number"
    t.string   "comment"
    t.boolean  "is_pcard_purchase"
    t.integer  "requisition_status_id"
  end

  add_index "requisitions", ["processor_id"], :name => "index_requisitions_on_processor_id"
  add_index "requisitions", ["purchase_order"], :name => "index_requisitions_on_purchase_order"
  add_index "requisitions", ["release_number"], :name => "index_requisitions_on_release_number"
  add_index "requisitions", ["requisition_number"], :name => "index_requisitions_on_requisition_number"
  add_index "requisitions", ["requisition_status_id"], :name => "index_requisitions_on_requisition_status_id"
  add_index "requisitions", ["requisitioned_on"], :name => "index_requisitions_on_requisitioned_on"
  add_index "requisitions", ["vendor_id"], :name => "index_requisitions_on_vendor_id"

  create_table "roles", :force => true do |t|
    t.string "name"
    t.text   "description"
    t.string "flag"
  end

  add_index "roles", ["flag"], :name => "index_roles_on_flag"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "roles_tasks", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "task_id"
  end

  add_index "roles_tasks", ["role_id"], :name => "index_roles_tasks_on_role_id"
  add_index "roles_tasks", ["task_id"], :name => "index_roles_tasks_on_task_id"

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "schema_info", :id => false, :force => true do |t|
    t.integer "version"
  end

  create_table "service_statuses", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "value"
  end

  add_index "service_statuses", ["name"], :name => "index_service_statuses_on_name"

  create_table "services", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  add_index "services", ["name"], :name => "index_services_on_name"

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "states", :force => true do |t|
    t.string "name"
    t.string "abbr"
  end

  add_index "states", ["name"], :name => "index_states_on_name", :unique => true

  create_table "subnets", :force => true do |t|
    t.text    "description"
    t.date    "date_installed"
    t.integer "network_class_id"
    t.integer "topology_id"
    t.boolean "is_delinquent"
    t.boolean "is_stealth"
    t.boolean "is_reserved"
    t.integer "vlanid"
    t.boolean "is_private"
    t.boolean "is_local"
    t.integer "virtual_lan_id"
  end

  add_index "subnets", ["network_class_id"], :name => "index_subnets_on_network_class_id"
  add_index "subnets", ["topology_id"], :name => "index_subnets_on_topology_id"
  add_index "subnets", ["virtual_lan_id"], :name => "index_subnets_on_virtual_lan_id"
  add_index "subnets", ["vlanid"], :name => "index_subnets_on_vlanid"

  create_table "tasks", :force => true do |t|
    t.string  "title"
    t.text    "description"
    t.string  "url"
    t.integer "task_group_id"
    t.integer "parent_id"
    t.string  "action"
    t.string  "controller"
    t.boolean "hidden"
  end

  add_index "tasks", ["action"], :name => "index_tasks_on_action"
  add_index "tasks", ["controller"], :name => "index_tasks_on_controller"
  add_index "tasks", ["parent_id"], :name => "index_tasks_on_parent_id"
  add_index "tasks", ["task_group_id"], :name => "index_tasks_on_task_group_id"
  add_index "tasks", ["title"], :name => "index_tasks_on_title"

  create_table "topologies", :force => true do |t|
    t.integer "parent_id"
    t.string  "name"
    t.text    "description"
    t.integer "old_topology_id"
  end

  add_index "topologies", ["name"], :name => "index_topologies_on_name"
  add_index "topologies", ["parent_id"], :name => "index_topologies_on_parent_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "dn"
    t.integer  "contact_id"
    t.datetime "last_login"
    t.string   "default_action"
    t.string   "default_controller"
    t.boolean  "logged_in"
  end

  add_index "users", ["contact_id"], :name => "index_users_on_contact_id"
  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "virtual_host_types", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  add_index "virtual_host_types", ["name"], :name => "index_virtual_host_types_on_name"

  create_table "virtual_lans", :force => true do |t|
    t.integer "vlanid"
    t.string  "name"
    t.text    "description"
    t.boolean "is_private"
  end

  add_index "virtual_lans", ["name"], :name => "index_virtual_lans_on_name"
  add_index "virtual_lans", ["vlanid"], :name => "index_virtual_lans_on_vlanid"

  create_table "wireless_interfaces", :force => true do |t|
    t.integer  "contact_id"
    t.integer  "interface_id"
    t.boolean  "is_enabled"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.text     "description"
    t.date     "expires_on"
    t.string   "hardware_address"
  end

  add_index "wireless_interfaces", ["contact_id"], :name => "index_wireless_interfaces_on_contact_id"
  add_index "wireless_interfaces", ["interface_id"], :name => "index_wireless_interfaces_on_interface_id"
  add_index "wireless_interfaces", ["is_enabled"], :name => "index_wireless_interfaces_on_is_enabled"

  create_table "wireless_output_filters", :force => true do |t|
    t.text     "title"
    t.text     "description"
    t.boolean  "is_active"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.text     "output_filter"
  end

  add_index "wireless_output_filters", ["is_active"], :name => "index_wireless_output_filters_on_is_active"

  create_table "workstations", :force => true do |t|
    t.integer "device_id"
    t.integer "contact_id"
    t.text    "description"
  end

  add_index "workstations", ["contact_id"], :name => "index_workstations_on_contact_id"
  add_index "workstations", ["device_id"], :name => "index_workstations_on_device_id"

  create_table "zones", :force => true do |t|
    t.integer "parent_id"
    t.string  "name"
    t.text    "description"
  end

  add_index "zones", ["name"], :name => "index_zones_on_name"
  add_index "zones", ["parent_id"], :name => "index_zones_on_parent_id"

end
