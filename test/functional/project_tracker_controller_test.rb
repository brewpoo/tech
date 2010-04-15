require File.dirname(__FILE__) + '/../test_helper'
require 'project_tracker_controller'

# Re-raise errors caught by the controller.
class ProjectTrackerController; def rescue_action(e) raise e end; end

class ProjectTrackerControllerTest < Test::Unit::TestCase
  def setup
    @controller = ProjectTrackerController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
