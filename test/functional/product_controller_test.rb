require File.dirname(__FILE__) + '/../test_helper'
require 'product_controller'

# Re-raise errors caught by the controller.
class ProductController; def rescue_action(e) raise e end; end

class ProductControllerTest < Test::Unit::TestCase
  def setup
    @controller = ProductController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
