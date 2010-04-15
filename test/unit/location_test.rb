require File.dirname(__FILE__) + '/../test_helper'

class LocationTest < Test::Unit::TestCase
  fixtures :locations

  # Replace this with your real tests.
  def test_truth
    assert true
  end

  def test_new_sub_location
    l=Location.new
    l.name="Third"
    l.parent=locations(:two)
    l.depth=2
    l.save
    assert !l.unsaved?
  end

end
