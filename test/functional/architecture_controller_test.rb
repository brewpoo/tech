require File.dirname(__FILE__) + '/../test_helper'
require 'architecture_controller'

# Re-raise errors caught by the controller.
class ArchitectureController; def rescue_action(e) raise e end; end

class ArchitectureControllerTest < Test::Unit::TestCase
  def setup
    @controller = ArchitectureController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
