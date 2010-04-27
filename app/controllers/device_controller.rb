class DeviceController < ApplicationController

  active_scaffold :device do |config|
    list.columns = [:hostname, :device_class, :description, :fqdn, :ipv4_interfaces]
    create.columns = update.columns = [:device, :hostname, :domain_names, :device_class, :description, :contact, :primary_interface, :interfaces]
    show.columns = [:device, :fqdn, :hostname, :device_class, :description, :contact, :primary_interface, :interfaces,
      :links]
    columns[:device].form_ui = :select
    columns[:device].label = "Hosted on"
    #columns[:domain].form_ui = :select
    columns[:device_class].form_ui = :select
    subform.columns = [:hostname, :device_class, :description, :contact]
    columns[:contact].form_ui = :select
    columns[:primary_interface].form_ui = :select
    list.sorting = {:hostname => :asc}
    list.per_page = 50
    nested.add_link("Interfaces", [:interfaces])
    nested.add_link("Equipment", [:equipment])
    nested.add_link("Links", [:links])
    nested.add_link("Logs", [:maintenance_logs])
    # Sorting and Searching
    columns[:device_class].sort_by :sql => 'device_classes.name'
    columns[:contact].sort_by :sql => 'contacts.last_name'
    columns[:contact].search_sql = 'contacts.last_name'
    columns[:equipment].sort_by :sql => 'equipment.serial_number'
    columns[:equipment].search_sql = 'equipment.serial_number'
    columns[:interfaces].includes = [:ipv4_interfaces]
    columns[:ipv4_interfaces].search_sql = 'ipv4_interfaces.ip_address'
    columns[:ipv4_interfaces].sort_by :sql => 'ipv4_interfaces.ip_address_packed'
    search.columns << [:contact, :equipment, :ipv4_interfaces]
    # Filters
    config.actions.add :list_filter
    config.list_filter.add(:association, :device_class, {:label => "Device Class", :association => [:device_class]})
  end

  def remove_orphans
    if request.post?
      count=0
      params[:orphan].each do |o|
        if o[:remove]=='1'
          Device.find(o[:id].to_i).destroy
          count=count+1
        end
      end
      flash[:notice]="#{count} orphaned devices removed"
      redirect_to :action => 'list' and return
    else
     @devices=Device.find(:all).reject!{|d| d.ipv4_interfaces.length > 0}
    end
  end

  def get_new_addresses
    if request.post?
      @skipped=[]
      @failed=[]
      @finished=[]
      # Process new devices
      params[:device].each do |device|
        @skipped << device and next if device[:hostname].blank?
        device_class = DeviceClass.find(device[:device_class])
        subnet = Subnet.find(device[:subnet])
        ip_address_packed=subnet.ipv4_subnet.get_and_hold_next_address(device_class)
        @failed << device and next unless ip_address_packed 
        new_device=Device.create(:hostname=>device[:hostname],:description=>device[:description],:device_class=>device_class)
        interface=new_device.create_in_interfaces(:name=>'unset')
        ipv4_interface=interface.create_in_ipv4_interfaces(:ip_address=>NetAddr::i_to_ip(ip_address_packed),:ipv4_subnet=>subnet.ipv4_subnet)
        new_device.save
        @finished << new_device        
      end
      render :action => 'get_new_addresses_complete'
    end
  end

  def add_auto_device
    @device_class = DeviceClass.find(params[:device_class].to_i) unless params[:device_class].to_i == 0
    @subnet = Subnet.find(params[:subnet].to_i) unless params[:subnet].to_i == 0
    render_js
  end

  def get_new_address
    @devices=Device.select_map
    @subnets=Subnet.select_map
    if request.post?
      @interface_name=params[:device][:interface] || 'unnamed'

      if params[:new_or_existing]=='existing'
        return_back("Select exisiting device") and return if params[:device][:id].empty?
        @device=Device.find(params[:device][:id])
        device_class=@device.device_class
      else
        return_back("Select device class") and return if params[:device][:device_class].empty?
        device_class=DeviceClass.find(params[:device][:device_class].to_i)
      end

      if params[:manual_or_auto]=='manual'
        return_back("Invalid Address") and return unless Ipv4Interface.valid_address? params[:device][:ip_address]
        packed_ip=NetAddr::ip_to_i(params[:device][:ip_address])
        return_back("Address not in assigned subnet") and return unless Ipv4AssignedNetwork.includes? packed_ip
        @ip_address=params[:device][:ip_address]
        return_back("Containing subnet does not exist") and return unless @ipv4_subnet=Ipv4Subnet.find_by_address(@ip_address)
        return_back("Address is already assigned") and return if @ipv4_subnet.address_used? packed_ip
      else
        # Get auto address
        return_back("Select Subnet to assign on") and return if params[:subnet][:id].empty?
        @ipv4_subnet=Subnet.find(params[:subnet][:id]).ipv4_subnet
        ip_address_packed=@ipv4_subnet.get_and_hold_next_address(device_class)
        return_back('Auto assign is not available') and return unless ip_address_packed
        @ip_address=NetAddr::i_to_ip(ip_address_packed)
      end
        
      if params[:new_or_existing]=='new'
        return_back("Enter name of device") and return if params[:device][:hostname].empty?
        description = params[:device][:description] || ''
        @device=Device.new(:hostname=>params[:device][:hostname],:device_class=>device_class,:description=>description)
      end

      @device.save if @device.new_record?
      render :action => 'address_confirm'
    end
  end

  def address_confirm
  end

  def address_show
  end

  def address_confirmed
    @device=Device.find(params[:device])
    @interface=@device.create_in_interfaces(:name=>params[:interface_name])
    @ipv4_subnet=Ipv4Subnet.find(params[:ipv4_subnet])
    @ipv4_interface=@interface.create_in_ipv4_interfaces(:ip_address=>params[:ip_address],:ipv4_subnet=>@ipv4_subnet)
    @ip_address=params[:ip_address]
    # Remove IP hold
    flash[:notice]='Address assigned'
    #if params[:equipment_details]
    #  e=@device.create_equipment
    #  @device.save
    #  e.save
    #  redirect_to :controller=>'equipment', :action=>'edit', :id=>e and return
    if @device.device_class == DeviceClass.find_by_name('Server')
      redirect_to :controller => 'server', :action => 'edit', :id => @device and return
    end
    if params[:device][:edit_device]
      redirect_to :action => 'edit', :id => @device and return
    end
    render :action => 'address_show'
  end

  def new_device_selected
    @device_classes=tree_select_map(DeviceClass.find(:all,:conditions=>'parent_id is null',:order=>'name'),0)
    render_js
  end

  def existing_device_selected
    @devices=Device.select_map
    render_js
  end

  def manual_address_selected
    render_js
  end

  def auto_address_selected
    @subnets=Subnet.select_map
    render_js
  end

  def move_existing_address
    if request.post?
    end
  end

  def subnet_changed
    return unless request.xhr?
    @subnet=Subnet.find(params[:id])
    render_js
  end

  def relinquish_address
    if request.post?
      return_back("Invalid Address") and return unless Ipv4Interface.valid_address? params[:device][:ip_address]
      packed_ip=NetAddr::ip_to_i(params[:device][:ip_address])
      return_back("Address not in assigned subnet") and return unless Ipv4AssignedNetwork.includes? packed_ip
      return_back("Address is not assigned or is dynamic") and return unless Ipv4Interface.address_used? packed_ip
      @ipv4_interface=Ipv4Interface.find_by_ip_address(params[:device][:ip_address])
      render :action => 'relinquish_confirm'
    end
  end

  def reqlinquish_confirm
  end

  def relinquish_confirmed
    if params[:ipv4_interface]
      @ipv4_interface=Ipv4Interface.find_by_ip_address(params[:ipv4_interface])
      if @ipv4_interface.device.interfaces.length==1
        @ipv4_interface.device.destroy
        flash[:notice]="Device destroyed and address reqlinquished"
      else
        @ipv4_interface.destroy
        flash[:notice]="Address reqlinquished"
      end
      redirect_to :action => 'list' and return
    end
  end

  def all_server_devices
    return unless request.xhr?
    @devices = Device.server_devices
    render_js
  end

  def all_devices
    return unless request.xhr?
    @devices = Device.all_devices
    render_js
  end

  def aging_cleanup
    if request.post?
      interface_count = 0
      device_count = 0
      Device.transaction do
        params[:remove_interfaces].each do |id,item|
          next if item[:delete]=='0'
          i=Ipv4Interface.find(id)
          if i.interface.device.ipv4_interfaces.length == 1
            i.interface.device.destroy
            device_count+=1
            interface_count+=1
          else
            i.destroy
            interface_count+=1
          end
        end
      end
      flash[:notice] = "Interfaces cleaned up: #{interface_count}, Devices Removed: #{device_count}"
      redirect_to :action => 'list' and return
    else
      @interfaces = Ipv4Interface.find(:all,:conditions => ['last_pinged_on < ?', Time.now - 60.days], :order => 'ip_address_packed asc').reject{|i| i.is_stealth or i.is_reserved or i.is_virtual or i.ipv4_subnet.subnet.is_stealth or i.ipv4_subnet.subnet.is_reserved or i.ipv4_subnet.subnet.is_local} 
    end
  end

end
