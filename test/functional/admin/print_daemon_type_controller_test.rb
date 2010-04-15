require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/print_daemon_type_controller'

# Re-raise errors caught by the controller.
class Admin::PrintDaemonTypeController; def rescue_action(e) raise e end; end

class Admin::PrintDaemonTypeControllerTest < Test::Unit::TestCase
  def setup
    @controller = Admin::PrintDaemonTypeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
