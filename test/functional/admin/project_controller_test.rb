require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/project_controller'

# Re-raise errors caught by the controller.
class Admin::ProjectController; def rescue_action(e) raise e end; end

class Admin::ProjectControllerTest < Test::Unit::TestCase
  def setup
    @controller = Admin::ProjectController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
