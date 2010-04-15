require File.dirname(__FILE__) + '/../test_helper'
require 'topology_controller'

# Re-raise errors caught by the controller.
class TopologyController; def rescue_action(e) raise e end; end

class TopologyControllerTest < Test::Unit::TestCase
  def setup
    @controller = TopologyController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
