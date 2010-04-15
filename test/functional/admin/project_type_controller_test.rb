require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/project_type_controller'

# Re-raise errors caught by the controller.
class Admin::ProjectTypeController; def rescue_action(e) raise e end; end

class Admin::ProjectTypeControllerTest < Test::Unit::TestCase
  def setup
    @controller = Admin::ProjectTypeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
