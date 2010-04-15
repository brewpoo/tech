require File.dirname(__FILE__) + '/../test_helper'
require 'device_class_controller'

# Re-raise errors caught by the controller.
class DeviceClassController; def rescue_action(e) raise e end; end

class DeviceClassControllerTest < Test::Unit::TestCase
  def setup
    @controller = DeviceClassController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
