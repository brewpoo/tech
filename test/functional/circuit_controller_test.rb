require File.dirname(__FILE__) + '/../test_helper'
require 'circuit_controller'

# Re-raise errors caught by the controller.
class CircuitController; def rescue_action(e) raise e end; end

class CircuitControllerTest < Test::Unit::TestCase
  def setup
    @controller = CircuitController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
