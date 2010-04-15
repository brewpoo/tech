require File.dirname(__FILE__) + '/../test_helper'
require 'load_balancer_controller'

# Re-raise errors caught by the controller.
class LoadBalancerController; def rescue_action(e) raise e end; end

class LoadBalancerControllerTest < Test::Unit::TestCase
  def setup
    @controller = LoadBalancerController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
