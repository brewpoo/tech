require File.dirname(__FILE__) + '/../test_helper'
require 'virtual_lan_controller'

# Re-raise errors caught by the controller.
class VirtualLanController; def rescue_action(e) raise e end; end

class VirtualLanControllerTest < Test::Unit::TestCase
  def setup
    @controller = VirtualLanController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
