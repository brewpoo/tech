require File.dirname(__FILE__) + '/../test_helper'
require 'equipment_status_controller'

# Re-raise errors caught by the controller.
class EquipmentStatusController; def rescue_action(e) raise e end; end

class EquipmentStatusControllerTest < Test::Unit::TestCase
  def setup
    @controller = EquipmentStatusController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
