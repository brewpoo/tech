require File.dirname(__FILE__) + '/../test_helper'
require 'project_update_controller'

# Re-raise errors caught by the controller.
class ProjectUpdateController; def rescue_action(e) raise e end; end

class ProjectUpdateControllerTest < Test::Unit::TestCase
  def setup
    @controller = ProjectUpdateController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
