require File.dirname(__FILE__) + '/../test_helper'
require 'operating_system_controller'

# Re-raise errors caught by the controller.
class OperatingSystemController; def rescue_action(e) raise e end; end

class OperatingSystemControllerTest < Test::Unit::TestCase
  def setup
    @controller = OperatingSystemController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
