require File.dirname(__FILE__) + '/../../test_helper'
require 'report/order_controller'

# Re-raise errors caught by the controller.
class Report::OrderController; def rescue_action(e) raise e end; end

class Report::OrderControllerTest < Test::Unit::TestCase
  def setup
    @controller = Report::OrderController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
