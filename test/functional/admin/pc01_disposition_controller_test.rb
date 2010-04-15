require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/pc01_disposition_controller'

# Re-raise errors caught by the controller.
class Admin::Pc01DispositionController; def rescue_action(e) raise e end; end

class Admin::Pc01DispositionControllerTest < Test::Unit::TestCase
  def setup
    @controller = Admin::Pc01DispositionController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
