class Domain < ActiveRecord::Base
  include TreeFunctions

  belongs_to :parent, 
    :class_name => "Domain",
    :foreign_key => "parent_id"
  belongs_to :maintainer,
    :class_name => "Contact",
    :foreign_key => "maintainer_id"
  has_many :domain_names, :dependent => :destroy
  has_and_belongs_to_many :servers, :association_foreign_key => 'server_id'
  belongs_to :primary_server, :class_name => "Server",
    :foreign_key => "primary_server_id"


  validates_presence_of :name
  validates_uniqueness_of :name, :scope => "parent_id"

  validates_presence_of :primary_server, :if => Proc.new { |domain| domain.autodns == true }

  def to_label
    fqdn
  end

  def build_forward_header
    return unless generate_soa?
    header  = <<eoc
; This file created by Tech AutoDNS feature, do not edit
$TTL 1H
@  SOA #{primary_server.fqdn}.  root.#{primary_server.fqdn}. (
\t#{Domain.new_serial} ;Serial
eoc

  if soa_timer_section.blank?
  header << <<eoc
\t3H ;Refresh
\t1H ;Retry
\t1W ;Expire
\t1H ;Minimum
eoc
  else
    header << soa_timer_section
  end
  header << "\n)\n\n"
    servers.each do |server|
      header << "\tNS\t#{server.fqdn}.\n"
    end
    return header
  end

  def build_reverse_header
    return unless generate_soa?
    header = <<eoc
$TTL 1H
@ SOA #{primary_server.fqdn}.  root.#{primary_server.fqdn}. (
\t#{Domain.new_serial} ;Serial
\t3H ;Refresh
\t1H ;Retry
\t1W ;Expire
\t1H ;Minimum
)
\tNS\t#{primary_server.fqdn}.
eoc
  end

  def reverse_file(subnet)
    if File.exists?("/tmp/autodns/#{primary_server.fqdn}/#{subnet.reverse_name}.db")
      reverse = File.new("/tmp/autodns/#{primary_server.fqdn}/#{subnet.reverse_name}.db", "a")
    else
      reverse = File.new("/tmp/autodns/#{primary_server.fqdn}/#{subnet.reverse_name}.db", "w")
      reverse << build_reverse_header
    end
    return reverse 
  end

  def forward_file
    FileUtils.mkpath("/tmp/autodns/#{primary_server.fqdn}")
    forward = File.new("/tmp/autodns/#{primary_server.fqdn}/#{fqdn}.db", "w+")
    forward << build_forward_header
    return forward
  end

  def self.clean_autodns
    FileUtils.rm_rf("/tmp/autodns")
  end

  def self.run_autodns
    Domain.find_all_by_autodns(true).each do |domain|
      forward = domain.forward_file
      # Add NS entries here
      domain.domain_names.each do |entry|
        forward << entry.nameable.forward_entry
        if entry.publish_reverse
          if entry.nameable.class == Ipv4VirtualHost
            reverse = domain.reverse_file(entry.nameable.ipv4_interface.ipv4_subnet)
            reverse << entry.nameable.reverse_entry
            reverse.close
          end
          if entry.nameable.class == Device
            # Push all interface reverses
            reverse = domain.reverse_file(entry.nameable.main_ip_address.ipv4_subnet)
            reverse << entry.nameable.reverse_entry
            reverse.close
            if entry.nameable.interfaces_count > 1
              entry.nameable.interfaces.each do |interface|
                next unless interface.ipv4_interfaces
                subnet = interface.ipv4_interfaces[0].ipv4_subnet 
                reverse = domain.reverse_file(subnet)
                reverse << interface.reverse_entry 
                reverse.close
              end # push interfaces
            end # Multi interface
          end # Device class
        end # publish_reverse
      end # Domains
      forward.close
    end 
  end

  def self.new_serial
    t=Time.now
    s=(t.seconds_since_midnight/(60*60*24)*10000).round
    "#{t.to_s(:serial)}#{s}"
  end

  def self.deploy_autodns
    Domain.clean_autodns
    Domain.run_autodns
    if ENV['RAILS_ENV']=='production'
      Domain.find_all_by_autodns(true).each do |domain|
        `ssh tech@#{domain.primary_server.fqdn} 'mkdir autodns'`
        `scp /tmp/autodns/#{domain.primary_server.fqdn}/* tech@#{domain.primary_server.fqdn}:autodns/`
      end
    end
  end

end

