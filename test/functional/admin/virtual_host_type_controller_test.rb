require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/virtual_host_type_controller'

# Re-raise errors caught by the controller.
class Admin::VirtualHostTypeController; def rescue_action(e) raise e end; end

class Admin::VirtualHostTypeControllerTest < Test::Unit::TestCase
  def setup
    @controller = Admin::VirtualHostTypeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
