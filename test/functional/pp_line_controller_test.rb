require File.dirname(__FILE__) + '/../test_helper'
require 'pp_line_controller'

# Re-raise errors caught by the controller.
class PpLineController; def rescue_action(e) raise e end; end

class PpLineControllerTest < Test::Unit::TestCase
  def setup
    @controller = PpLineController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
