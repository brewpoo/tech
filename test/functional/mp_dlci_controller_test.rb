require File.dirname(__FILE__) + '/../test_helper'
require 'mp_dlci_controller'

# Re-raise errors caught by the controller.
class MpDlciController; def rescue_action(e) raise e end; end

class MpDlciControllerTest < Test::Unit::TestCase
  def setup
    @controller = MpDlciController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
