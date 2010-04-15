require File.dirname(__FILE__) + '/../test_helper'
require 'mp_line_controller'

# Re-raise errors caught by the controller.
class MpLineController; def rescue_action(e) raise e end; end

class MpLineControllerTest < Test::Unit::TestCase
  def setup
    @controller = MpLineController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
