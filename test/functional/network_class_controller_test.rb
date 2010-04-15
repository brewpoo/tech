require File.dirname(__FILE__) + '/../test_helper'
require 'network_class_controller'

# Re-raise errors caught by the controller.
class NetworkClassController; def rescue_action(e) raise e end; end

class NetworkClassControllerTest < Test::Unit::TestCase
  def setup
    @controller = NetworkClassController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
