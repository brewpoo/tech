require File.dirname(__FILE__) + '/../test_helper'
require 'pc01_controller'

# Re-raise errors caught by the controller.
class Pc01Controller; def rescue_action(e) raise e end; end

class Pc01ControllerTest < Test::Unit::TestCase
  def setup
    @controller = Pc01Controller.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
