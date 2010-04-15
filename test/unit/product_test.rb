require File.dirname(__FILE__) + '/../test_helper'

class ProductTest < Test::Unit::TestCase
  fixtures :products

  def test_unique_vendor_model_number
    p=Product.new
    p.model_number="1234-1234"
    p.vendor_id=2
    assert !p.save
  end
end
