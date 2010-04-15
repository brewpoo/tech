require File.dirname(__FILE__) + '/../test_helper'

class ZoneTest < Test::Unit::TestCase

  fixtures :zones

  def test_save_zone
    zone = Zone.new
    zone.name="Tthird"
    assert zone.save
  end

  def test_duplicate_zone
    zone = Zone.new
    zone.name="First"
    assert !zone.save,"Duplicate Record"
  end

  def test_set_parent
    zone=Zone.new
    zone.name="Third"
    zone.parent=zones(:first)
    assert zone.save
  end

end
