require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/ipv4_scope_option_controller'

# Re-raise errors caught by the controller.
class Admin::Ipv4ScopeOptionController; def rescue_action(e) raise e end; end

class Admin::Ipv4ScopeOptionControllerTest < Test::Unit::TestCase
  def setup
    @controller = Admin::Ipv4ScopeOptionController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
