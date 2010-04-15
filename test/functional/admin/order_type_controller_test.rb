require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/order_type_controller'

# Re-raise errors caught by the controller.
class Admin::OrderTypeController; def rescue_action(e) raise e end; end

class Admin::OrderTypeControllerTest < Test::Unit::TestCase
  def setup
    @controller = Admin::OrderTypeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
