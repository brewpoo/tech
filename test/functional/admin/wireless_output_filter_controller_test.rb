require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/wireless_output_filter_controller'

# Re-raise errors caught by the controller.
class Admin::WirelessOutputFilterController; def rescue_action(e) raise e end; end

class Admin::WirelessOutputFilterControllerTest < Test::Unit::TestCase
  def setup
    @controller = Admin::WirelessOutputFilterController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
