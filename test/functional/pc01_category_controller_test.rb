require File.dirname(__FILE__) + '/../test_helper'
require 'pc01_category_controller'

# Re-raise errors caught by the controller.
class Pc01CategoryController; def rescue_action(e) raise e end; end

class Pc01CategoryControllerTest < Test::Unit::TestCase
  def setup
    @controller = Pc01CategoryController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
