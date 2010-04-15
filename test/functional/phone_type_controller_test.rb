require File.dirname(__FILE__) + '/../test_helper'
require 'phone_type_controller'

# Re-raise errors caught by the controller.
class PhoneTypeController; def rescue_action(e) raise e end; end

class PhoneTypeControllerTest < Test::Unit::TestCase
  def setup
    @controller = PhoneTypeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
