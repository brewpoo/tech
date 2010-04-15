require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/audit_controller'

# Re-raise errors caught by the controller.
class Admin::AuditController; def rescue_action(e) raise e end; end

class Admin::AuditControllerTest < Test::Unit::TestCase
  def setup
    @controller = Admin::AuditController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
