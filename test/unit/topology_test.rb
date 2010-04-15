require File.dirname(__FILE__) + '/../test_helper'

class TopologyTest < Test::Unit::TestCase
  fixtures :topologies

  def test_new_sub_topology
    t=Topology.new
    t.name="802.11g"
    t.parent=topologies(:two)
    t.save
    assert !t.unsaved?
  end

  def test_unique_parent
    t=Topology.new
    t.name="802.11g"
    t.parent=topologies(:two)
    t.save
    assert !t.unsaved?
  end

  def test_unique
    t=Topology.new
    t.name="802.11b"
    t.parent=topologies(:two)
    assert !t.save
  end
end
