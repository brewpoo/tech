require File.dirname(__FILE__) + '/../test_helper'
require 'product_family_controller'

# Re-raise errors caught by the controller.
class ProductFamilyController; def rescue_action(e) raise e end; end

class ProductFamilyControllerTest < Test::Unit::TestCase
  def setup
    @controller = ProductFamilyController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
