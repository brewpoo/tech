require File.dirname(__FILE__) + '/../test_helper'
require 'maintenance_log_controller'

# Re-raise errors caught by the controller.
class MaintenanceLogController; def rescue_action(e) raise e end; end

class MaintenanceLogControllerTest < Test::Unit::TestCase
  def setup
    @controller = MaintenanceLogController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
