require File.dirname(__FILE__) + '/../test_helper'
require 'application_server_controller'

# Re-raise errors caught by the controller.
class ApplicationServerController; def rescue_action(e) raise e end; end

class ApplicationServerControllerTest < Test::Unit::TestCase
  def setup
    @controller = ApplicationServerController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
