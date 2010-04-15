require File.dirname(__FILE__) + '/../test_helper'
require 'project_whiteboard_controller'

# Re-raise errors caught by the controller.
class ProjectWhiteboardController; def rescue_action(e) raise e end; end

class ProjectWhiteboardControllerTest < Test::Unit::TestCase
  def setup
    @controller = ProjectWhiteboardController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
