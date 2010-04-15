require File.dirname(__FILE__) + '/../test_helper'
require 'cluster_controller'

# Re-raise errors caught by the controller.
class ClusterController; def rescue_action(e) raise e end; end

class ClusterControllerTest < Test::Unit::TestCase
  def setup
    @controller = ClusterController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
