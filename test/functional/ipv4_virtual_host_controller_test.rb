require File.dirname(__FILE__) + '/../test_helper'
require 'ipv4_virtual_host_controller'

# Re-raise errors caught by the controller.
class Ipv4VirtualHostController; def rescue_action(e) raise e end; end

class Ipv4VirtualHostControllerTest < Test::Unit::TestCase
  def setup
    @controller = Ipv4VirtualHostController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
