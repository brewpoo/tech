require File.dirname(__FILE__) + '/../test_helper'
require 'dial_line_controller'

# Re-raise errors caught by the controller.
class DialLineController; def rescue_action(e) raise e end; end

class DialLineControllerTest < Test::Unit::TestCase
  def setup
    @controller = DialLineController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
