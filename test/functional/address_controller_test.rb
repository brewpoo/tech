require File.dirname(__FILE__) + '/../test_helper'
require 'address_controller'

# Re-raise errors caught by the controller.
class AddressController; def rescue_action(e) raise e end; end

class AddressControllerTest < Test::Unit::TestCase
  def setup
    @controller = AddressController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
