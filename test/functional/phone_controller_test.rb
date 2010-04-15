require File.dirname(__FILE__) + '/../test_helper'
require 'phone_controller'

# Re-raise errors caught by the controller.
class PhoneController; def rescue_action(e) raise e end; end

class PhoneControllerTest < Test::Unit::TestCase
  def setup
    @controller = PhoneController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
