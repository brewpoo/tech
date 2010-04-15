require File.dirname(__FILE__) + '/../test_helper'

class AddressTest < Test::Unit::TestCase
  fixtures :addresses

  def test_duplicate
    a=Address.new
    a.street_address="8 Plum"
    a.city_id=1
    assert !a.save
  end
end

