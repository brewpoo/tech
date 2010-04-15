require File.dirname(__FILE__) + '/../test_helper'
require 'ipv4_virtual_interface_controller'

# Re-raise errors caught by the controller.
class Ipv4VirtualInterfaceController; def rescue_action(e) raise e end; end

class Ipv4VirtualInterfaceControllerTest < Test::Unit::TestCase
  def setup
    @controller = Ipv4VirtualInterfaceController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
