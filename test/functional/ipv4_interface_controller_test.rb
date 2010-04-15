require File.dirname(__FILE__) + '/../test_helper'
require 'ipv4_interface_controller'

# Re-raise errors caught by the controller.
class Ipv4InterfaceController; def rescue_action(e) raise e end; end

class Ipv4InterfaceControllerTest < Test::Unit::TestCase
  def setup
    @controller = Ipv4InterfaceController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
