require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/ipv4_scope_controller'

# Re-raise errors caught by the controller.
class Admin::Ipv4ScopeController; def rescue_action(e) raise e end; end

class Admin::Ipv4ScopeControllerTest < Test::Unit::TestCase
  def setup
    @controller = Admin::Ipv4ScopeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
