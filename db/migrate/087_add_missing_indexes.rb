class AddMissingIndexes < ActiveRecord::Migration
  def self.up
    add_index :addresses, :state_id
    add_index :circuits, :line_type_id
    add_index :circuits_locations, :location_id
    add_index :circuits_locations, :circuit_id
    add_index :cities, :name
    add_index :cities, :state_id
    add_index :cities, :po_zip
    add_index :companies, :is_manufacturer
    add_index :components, :parent_id
    add_index :contacts, :is_purchase_contact
    add_index :departments, :company_id
    add_index :device_classes, :name
    add_index :devices, :domain_id
    add_index :devices, :primary_interface_id
    add_index :distributed_items, :contact_id
    add_index :distributed_items, :order_item_id
    add_index :distributed_items, :distributed_on
    add_index :distributed_items, :processor_id
    add_index :domain_entries, :ipv4_interface_id
    add_index :domains, :name
    add_index :domains, :autodns
    add_index :domains, :maintainer_id
    add_index :domains_servers, :domain_id
    add_index :domains_servers, :server_id
    add_index :equipment, :serial_number
    add_index :equipment, :equipment_status_id
    add_index :equipment, :role_id
    add_index :equipment_statuses, :name
    add_index :interfaces, :is_wireless
    add_index :ipv4_address_holds, :ipv4_subnet_id
    add_index :ipv4_address_holds, :ip_address_packed
    add_index :ipv4_address_holds, :held_on
    add_index :ipv4_scopes, :ipv4_subnet_id
    add_index :ipv4_scopes, :server_id
    add_index :ipv4_scopes, :gateway_id
    add_index :ipv4_virtual_host_interfaces, :ipv4_virtual_host_id
    add_index :ipv4_virtual_host_interfaces, :ipv4_interface_id
    add_index :line_types, :parent_id
    add_index :line_types, :name
    add_index :locations, :long_name
    add_index :locations, :depth
    add_index :locations, :is_delivery_location
    add_index :locations, :is_storage_location
    add_index :locations, :is_data_center
    add_index :mp_dlcis, :mp_line_id
    add_index :mp_dlcis, :interface_id
    add_index :mp_lines, :device_id
    add_index :mp_lines, :circuit_id
    add_index :mp_pvcs, :dlci_a_id
    add_index :mp_pvcs, :dlci_b_id
    add_index :order_items, :product_id
    add_index :order_items, :quantity
    add_index :order_items, :order_id
    add_index :order_statuses, :name
    add_index :order_types, :name
    add_index :order_types, :processor_id
    add_index :orders, :order_number
    add_index :orders, :ordered_on
    add_index :orders, :requestor_id
    add_index :orders, :is_approved
    add_index :orders, :department_id
    add_index :orders, :order_type_id
    add_index :orders, :manager_id
    add_index :orders, :project_id
    add_index :orders, :pc01_id
    add_index :orders, :closed_on
    add_index :orders, :order_status_id
    add_index :pc01_categories, :title
    add_index :pc01_items, :pc01_id
    add_index :pc01_items, :pc01_category_id
    add_index :pc01_items, :is_stock_item
    add_index :pc01_items, :is_fullfilled
    add_index :pc01_items, :is_replenished
    add_index :pc01_items, :is_charge_back
    add_index :pc01s, :pc01_number
    add_index :pc01s, :received_on
    add_index :pc01s, :approved_on
    add_index :pc01s, :submitted_by
    add_index :pc01s, :location_id
    add_index :pc01s, :department_id
    add_index :phone_types, :phone_type
    add_index :pp_lines, :circuit_id
    add_index :pp_lines, :subnet_id
    add_index :pp_lines, :map_reference
    add_index :printers, :device_id
    add_index :product_attributes, :product_id
    add_index :product_attributes, :attribute_id
    add_index :product_families, :name
    add_index :projects, :title
    add_index :projects, :manager_id
    add_index :projects, :department_id
    add_index :projects, :requestor_id
    add_index :received_items, :received_on
    add_index :received_items, :receiver_id
    add_index :received_items, :requisition_item_id
    add_index :related_tasks, :task_id
    add_index :related_tasks, :related_task_id
    add_index :reports, :title
    add_index :reports, :action
    add_index :reports, :controller
    add_index :requisition_items, :requisition_id
    add_index :requisition_items, :order_item_id
    add_index :requisition_items, :quantity
    add_index :requisition_statuses, :name
    add_index :requisitions, :requisitioned_on
    add_index :requisitions, :requisition_number
    add_index :requisitions, :purchase_order
    add_index :requisitions, :vendor_id
    add_index :requisitions, :requisition_status_id
    add_index :requisitions, :processor_id
    add_index :requisitions, :release_number
    add_index :servers, :device_id
    add_index :servers, :primary_engineer_id
    add_index :servers, :is_san_connected
    add_index :servers, :is_tivoli_agent
    add_index :subnets, :vlanid
    add_index :subnets, :virtual_lan_id
    add_index :tasks, :action
    add_index :tasks, :controller
    add_index :users, :contact_id
    add_index :virtual_lans, :vlanid
    add_index :virtual_lans, :name
    add_index :wireless_interfaces, :contact_id
    add_index :wireless_interfaces, :interface_id
    add_index :wireless_interfaces, :is_enabled
    add_index :wireless_output_filters, :is_active
    add_index :workstations, :device_id
    add_index :workstations, :contact_id
  end

  def self.down
  end
end