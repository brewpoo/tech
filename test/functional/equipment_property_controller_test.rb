require File.dirname(__FILE__) + '/../test_helper'
require 'equipment_property_controller'

# Re-raise errors caught by the controller.
class EquipmentPropertyController; def rescue_action(e) raise e end; end

class EquipmentPropertyControllerTest < Test::Unit::TestCase
  def setup
    @controller = EquipmentPropertyController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
