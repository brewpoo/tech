#!/usr/bin/env ruby
#

def set_project_priority(priority)
  case priority
  when "Low"
    return 1
  when "Medium"
    return 3
  when "High"
    return 5
  end
end

def set_project_status(status)
  case status
  when "Not Started"
    return 0
  when "In-Progress"
    return 1
  when "Pending"
    return 2
  when "Complete"
    return 3
  end
end

def get_mask(id)
  case id
    when 1
      return "255.255.255.0"
    when 2
      return "255.255.255.128"
    when 3
      return "255.255.255.252"
    when 4
      return "255.255.255.240"
    when 5
      return "255.255.255.192"
    when 7
      return "255.255.255.224"
    when 8
      return "255.255.255.248"
    when 9
      return "255.0.0.0"
    when 10
      return "255.255.0.0"
    when 11
      return "255.255.255.255"
  end
end

def lookup_provider(id)
end

def lookup_circuit_type(app)
  case app
    when "PtP"
      return CircuitType.find_by_flag('p2p')
    when "Dial"
      return CircuitType.find_by_flag('dl')
    when "FR"
      return CircuitType.find_by_flag('mp')
  end
end

if ARGV.length < 2
  puts "Usage: <model> <file>\n"
  exit 0
end

model = ARGV[ARGV.length-2]
filename = ARGV[ARGV.length-1]

begin

  f = File.open(filename)

  case model
  when "build_hosts"
    f.each { |line|
      record=line.split(",")
      device_class = DeviceClass.find_by_name(record[2])
      next if device_class == nil
      next unless Ipv4Interface.valid_address? record[0]
      packed_ip=NetAddr::ip_to_i(record[0])
      next unless Ipv4AssignedNetwork.includes? packed_ip
      next unless ipv4_subnet=Ipv4Subnet.find_by_address(record[0])
      next if ipv4_subnet.address_used? packed_ip
      device=Device.create(:hostname=>record[1],:device_class=>device_class,:description=>"#{record[3]} #{record[1]}")
      interface=device.create_in_interfaces(:name=>"unset")
      ipv4_interface=interface.create_in_ipv4_interfaces(:ip_address=>record[0],:ipv4_subnet=>ipv4_subnet)
      print "Created #{record[0]}\n"
  }
  when "location"
    f.each { |line|
      record=line.split(",")
      first = Location.find(:first, :conditions=> ['name=? and depth=0',record[1]]) || Location.create(:name => record[1])
      second = Location.find(:first,:conditions=>['name=? and parent_id=?',record[2].strip,first.id]) || first.create_in_children(:name=>record[2].strip)
      third = Location.find(:first,:conditions=>['name=? and parent_id=?',record[3].strip,second.id]) || second.create_in_children(:name=>record[3].strip)
      fourth = Location.find(:first,:conditions=>['name=? and parent_id=?',record[4].strip,third.id]) || third.create_in_children(:name=>record[4].strip)

      second.update_attribute(:nick_name,record[5]) unless record[5].nil?
      fourth.update_attribute(:old_id,record[0])
    }
  when "state"
    State.destroy_all
    f.each { |line|
      record=line.split(",")
      State.create(:name=>record[0].delete("\""),:abbr=>record[1].delete("\"")) 
    }
  when "project"
    f.each { |line|
      record=line.split(",")
      project_type=ProjectType.find_by_abbreviation("PN")
      project = Project.find_by_project_number("PN#{record[0]}")
      puts("PN#{record[0]}...")
      priority=Priority.find_by_name(record[4]) || Priority.find_by_name("Medium")
      project_status = ProjectStatus.find_by_name(record[10]) || ProjectStatus.find_first
      manager=Contact.find_by_last_name(record[5].split(" ")[1]) || nil
      puts(record[5].split(" ")[1])
      names=record[6].split(" ")
      if names.length==2
        engineer=Contact.find(:first,:conditions=>['last_name = ? and first_name = ?',names[1],names[0]])
      elsif names.length==1
        engineer=Contact.find(:first,:conditions=>['last_name = ?',names[0]])
      else
        engineer=nil
      end
      names=record[8].split(" ")
      if names.length==2
        requestor=Contact.find(:first,:conditions=>['last_name = ? and first_name = ?',names[1],names[0]]) || Contact.create(:last_name=>names[1], :first_name=>names[0])
      elsif names.length==1
        requestor=Contact.find(:first,:conditions=>['last_name = ?',names[0]])
      else
        requestor=nil
      end
      if project
        puts("found, updating\n")
        project.update_attributes(:project_number => record[0], :title => record[9], :description => record[11], :project_type => project_type,
      :requested_on => record[1], :requestor => requestor, :started_on => record[2], :estimated_completion => record[3], :priority => priority,
      :project_status => project_status, :department => Department.find_by_name(record[7]) || nil,
      :manager => manager,
      :engineer => engineer)
      else
        puts("not found, creating\n")
        Project.create(:project_number => record[0], :title => record[9], :description => record[11], :project_type => project_type,
      :requested_on => record[1], :requestor => requestor, :started_on => record[2], :estimated_completion => record[3], :priority => priority,
      :project_status => project_status, :department => Department.find_by_name(record[7]) || nil,
      :manager => manager, 
      :engineer => engineer )
      end
    }
  when "whiteboard"
    f.each { |line|
      record=line.split(",")
      project_type=ProjectType.find_by_abbreviation("WB")
      project = Project.find_by_project_number("PN#{record[0]}")
      puts("WB#{record[0]}...")
      priority=Priority.find_by_name(record[3]) || Priority.find_by_name("Medium")
      project_status = ProjectStatus.find_by_name(record[9]) || ProjectStatus.find_first
      manager=Contact.find_by_last_name(record[4]) || nil
      names=record[5].split(" ")
      if names.length==2
        engineer=Contact.find(:first,:conditions=>['last_name = ? and first_name = ?',names[1],names[0]])
      elsif names.length==1
        engineer=Contact.find(:first,:conditions=>['last_name = ?',names[0]])
      else
        engineer=nil
      end
      names=record[7].split(" ")
      if names.length==2
        requestor=Contact.find(:first,:conditions=>['last_name = ? and first_name = ?',names[1],names[0]]) || Contact.create(:last_name=>names[1], :first_name=>names[0])
      elsif names.length==1
        requestor=Contact.find(:first,:conditions=>['last_name = ?',names[0]])
      else
        requestor=nil
      end
      if project
        puts("found, updating\n")
        project.update_attributes(:project_number => record[0], :title => record[8], :description => record[10], :project_type => project_type,
      :requestor => requestor, :started_on => record[1], :estimated_completion => record[2], :priority => priority,
      :project_status => project_status, :department => Department.find_by_name(record[6]) || nil,
      :manager => manager,
      :engineer => engineer)
      else
        puts("not found, creating\n")
        Project.create(:project_number => record[0], :title => record[8], :description => record[10], :project_type => project_type,
      :requestor => requestor, :started_on => record[1], :estimated_completion => record[2], :priority => priority,
      :project_status => project_status, :department => Department.find_by_name(record[6]) || nil,
      :manager => manager,
      :engineer => engineer )
      end
    }

  when "wireless"
    f.each { |line|
      record=line.split(",")
      contact=Contact.find_by_last_name(record[0]) || Contact.new(:last_name => record[0], :first_name => record[1])
      interface=Interface.create(:hardware_address => record[2].chop, :topology => Topology.find_by_name('Wireless'), :is_wireless => true)
      WirelessInterface.create(:interface => interface, :contact => contact, :is_enabled => true)
    }
  when "ipv4_assigned_network"
    f.each { |line|
      record=line.split(",")
      Ipv4AssignedNetwork.create(:subnet_address => record[1].strip, :prefix => NetAddr::mask_to_bits(NetAddr::netmask_to_i(record[2].strip)),:description => record[3].strip)
    }
  when "networks"
    # From Network_tbl
    f.each { |line|
      record=line.split(",")
      date = record[8].empty? ? nil : record[8].to_date
      subnet=Subnet.create(:description=>record[5].strip,:date_installed=>date,
            :network_class=>NetworkClass.find_by_old_netclass_id(record[6].to_i),
            :topology=>Topology.find_by_old_topology_id(record[7].to_i),
            :is_delinquent=>record[11].to_i.odd?,:is_stealth=>record[15].to_i.odd?,
            :is_reserved=>record[14].to_i.odd?)
      gateway_address = record[12].empty? ? nil : record[12].strip
      ipv4_subnet=subnet.create_ipv4_subnet(:zone=>Zone.find_first,:subnet_address=>record[1].strip,:subnet_mask=>get_mask(record[3].to_i),
            :old_network_id=>record[0].to_i,:gateway_address=>gateway_address)
    }
  when "hosts"
    # From Host_tbl
    f.each { |line|
      record=line.split(",")
      equipment=Equipment.create(:location=>Location.find_by_old_id(record[4].to_i),:equipment_status=>EquipmentStatus.find(3),
          :count=>1)
      device=Device.create(:hostname=>record[2].strip,:description=>record[3].strip,:equipment=>equipment,
          :device_class=>DeviceClass.find_by_old_hostclass_id(record[1].to_i),:old_host_id=>record[0].to_i,
          :is_virtual=>record[5].to_i.odd?)
    }
  when "interfaces"
    # From HostInterface_tbl
    f.each { |line|
      record=line.split(",")
      network=Ipv4Subnet.find_by_old_network_id(record[2].to_i)
      next if network.nil?
      interface=Interface.create(:device=>Device.find_by_old_host_id(record[1].to_i),:topology=>network.subnet.topology,:name=>'unset')
      ipv4_interface=Ipv4Interface.create(:ipv4_subnet=>network,:interface=>interface,:ip_address=>record[5].strip,
          :old_interface_id=>record[0].to_i,
          :is_rogue=>record[8].to_i.odd?, :is_delinquent=>record[9].to_i.odd?, :is_virtual=>record[13].to_i.odd?)
    }
  when "scopes"
    # From Scope_tbl
    f.each { |line|
      record=line.split(",")
      name = record[3].empty? ? "no name" : record[3].strip
      scope=Ipv4Scope.create(:name=>record[3].strip,:server=>Device.find_by_old_host_id(record[2].to_i),
        :ipv4_subnet=>Ipv4Subnet.find_by_old_network_id(record[1]))
      range=Ipv4AddressRange.create(:ipv4_scope=>scope,:is_dynamic=>true,
        :start_address=>record[8].strip,:end_address=>record[9].strip)
    }
  when "schema"
    # From IPRule_tbl
    f.each { |line|
      record=line.split(",")
      Ipv4SchemaRule.create(:network_address=>record[1].strip,:network_mask=>record[2].strip,
        :device_class=>DeviceClass.find_by_old_hostclass_id(record[3].to_i),
        :lbound=>record[4].to_i, :ubound=>record[5].to_i, :zone=>Zone.find_first)
    }
    when "virtualhosts"
      # From VirtualHost_tbl
      f.each { |line|
        record=line.split(",")
        i=Ipv4VirtualHost.new(:ipv4_subnet=>Ipv4Subnet.find_by_old_network_id(record[1].to_i),
          :vrid=>record[2].to_i,:description=>record[4].strip,
          :ipv4_interface=>Ipv4Interface.find_by_old_interface_id(record[3].to_i),
          :is_vrrp=>true, :old_virtual_id=>record[0].to_i)
        i.save_without_validation
      }
    when "virtualinterfaces"
      # From HostInterface_tbl
      f.each { |line|
        record=line.split(",")
        next if record[12].empty? or record[13].to_i.odd? or record[12].to_i == 0
        print "old_id = #{record[0]}\n"
        Ipv4VirtualHostInterface.create(:ipv4_virtual_host=>Ipv4VirtualHost.find_by_old_virtual_id(record[12].to_i),
          :ipv4_interface=>Ipv4Interface.find_by_old_interface_id(record[0].to_i),:priority=>254)
      }
    when "circuits"
      count = 0
      f.each { |line|
        count = count + 1
        print "#{count}\n"
        record=line.split(",")
        #date = record[12].empty? ? nil : record[12].strip.to_date
        circuit = Circuit.create(:old_circuit_id=>record[0].to_i,:provider=>lookup_provider(record[1].to_i),
          :line_type=>LineType.find_by_old_channel_id(record[2].to_i),:line_speed=>LineSpeed.find_by_old_linespeed_id(record[3].to_i),
          :circuit_number=>record[4].strip,:description=>record[5].strip,
          :circuit_type => lookup_circuit_type(record[9].strip),
          :is_disconnected => record[11].to_i.odd?)
        circuit.locations << (Location.find_by_old_id(record[6].to_i).nil? ? Location.new : Location.find_by_old_id(record[6].to_i))
        circuit.locations << (Location.find_by_old_id(record[7].to_i).nil? ? Location.new : Location.find_by_old_id(record[7].to_i))
        circuit.save
      }
    when "pplines"
      count = 0
      f.each { |line|
        record=line.split(",")
        count=count+1
        print "#{count}\n"
        PpLine.create(:circuit=>Circuit.find_by_old_circuit_id(record[1].to_i),:subnet=>Ipv4Subnet.find_by_old_network_id(record[2].to_i).subnet,
                      :map_reference=>record[3].to_i)
      }
    when "diallines"
      # From DialLine_tbl
      f.each { |line|
        record=line.split(",")
        dl=DialLine.create(:circuit=>Circuit.find_by_old_circuit_id(record[1].to_i), :device=>Device.find_by_old_host_id(record[4].to_i))
        dl.create_in_phones(:number=>record[3],:phone_type=>PhoneType.find_by_phone_type("SPID"))
        dl.save!
      }

    when "mplines"
      f.each { |line|
        record=line.split(",")
        MpLine.create(:circuit=>Circuit.find_by_old_circuit_id(record[2].to_i),:device=>Device.find_by_old_host_id(record[1].to_i),
                      :old_mp_line_id=>record[0].to_i)
      }

    when "mpdlcis"
      f.each { |line|
        record=line.split(",")
        MpDlci.create(:dlci=>record[1].to_i,:mp_line=>MpLine.find_by_old_mp_line_id(record[2].to_i),
          :interface=>Ipv4Interface.find_by_old_interface_id(record[3].to_i).interface,
          :old_dlci_id=>record[0].to_i)
      }

    when "mppvcs"
      f.each { |line|
        record=line.split(",")
        MpPvc.create(:dlci_a=>MpDlci.find_by_old_dlci_id(record[1].to_i),:dlci_b=>MpDlci.find_by_old_dlci_id(record[2].to_i),
                      :old_pvc_id=>record[0].to_i)
      }

    when "assigned_subnets"
      f.each { |line|
        record=line.split(",")
        Ipv4AssignedNetwork.create(:description=>record[3].strip,:subnet_address=>record[1].strip,
          :prefix=>NetAddr::mask_to_bits(NetAddr::netmask_to_i(record[2])))
      }
    when "vlans"
      f.each { |line|
        record=line.split(",")
        net=record[4].strip[0..record[4].strip.length-4]
        if record[2].to_i == 0
          # Not unique, just update the containing subnet
          network=Ipv4Subnet.find_by_subnet_address(net)
          print "#{net} not found\n" and next if network.nil?
          network.subnet.vlanid=record[0].to_i
          network.subnet.save
        else
          # Unique, need to create a virtual_lan
          vlan=VirtualLan.create(:vlanid=>record[0].to_i,:name=>record[1].strip)
          vlan.is_private = true if record[3].to_i == 0
          vlan.save
          network=Ipv4Subnet.find_by_subnet_address(net)
          next if network.nil?
          network.subnet.virtual_lan = vlan
          network.subnet.save
        end
      }
    when "adm"
      f.each { |line|
        record=line.split(",")
        name=record[0].strip  
        address=record[1].strip
        interface=Ipv4Interface.find_by_ip_address(address)
      
        domain=Domain.find_by_name('adm')
        newclass=DeviceClass.find_by_name('RIB/ILO')
        if interface.nil?
          print" #{name} #{address} unmatched -- skipping\n"
        else
          print "#{name} #{address} matched on #{interface.device.hostname}\n"
          newname=name.gsub(/\-*(rib|ilo)$/,'') 
          interface.device.domain_names.each {|dn| dn.destroy}
          interface.device.create_in_domain_names(:hostname=>newname,:domain=>domain,:publish_reverse=>1)
          interface.device.update_attributes(:description=>"#{newname} admin (rib/ilo/lom) interface",:device_class=>newclass)
        end
      }

  else
    print "Error, import type not defined\n"

  end

  rescue Errno::ENOENT
    print "File was not found\n"
  rescue
    raise $!
  ensure 
    f.close if f
end

