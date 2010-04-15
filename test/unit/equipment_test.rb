require File.dirname(__FILE__) + '/../test_helper'

class EquipmentTest < Test::Unit::TestCase
  fixtures :equipment

  def test_duplicate_tag_number
    e=Equipment.new
    e.product_id=1
    e.tag_number=123456
    assert !e.save
  end
end
