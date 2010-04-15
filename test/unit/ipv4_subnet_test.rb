require File.dirname(__FILE__) + '/../test_helper'

class Ipv4SubnetTest < Test::Unit::TestCase
  fixtures :ipv4_subnets

  # Replace this with your real tests.
  def test_truth
    assert true
  end

  def test_new_subnet
    net=Ipv4Subnet.new
    net.subnet_address=NetAddr::pack_ip_addr('172.17.2.0')
    net.subnet_mask=NetAddr::pack_ip_netmask('/24')
    net.save
    assert !net.unsaved?, "Saved"
  end

  def test_missing_mask
    net=Ipv4Subnet.new
    net.subnet_address=NetAddr::pack_ip_addr('172.17.1.0')
    assert !net.save, "Missing subnet mask!"
  end

  def test_unique
    net=Ipv4Subnet.new
    net.subnet_address=NetAddr::pack_ip_addr('172.17.1.0')
    net.subnet_mask=NetAddr::pack_ip_netmask('/24')
    assert !net.save, "Saved"
  end


end
