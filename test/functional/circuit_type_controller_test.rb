require File.dirname(__FILE__) + '/../test_helper'
require 'circuit_type_controller'

# Re-raise errors caught by the controller.
class CircuitTypeController; def rescue_action(e) raise e end; end

class CircuitTypeControllerTest < Test::Unit::TestCase
  def setup
    @controller = CircuitTypeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
