require File.dirname(__FILE__) + '/../test_helper'
require 'attachment_controller'

# Re-raise errors caught by the controller.
class AttachmentController; def rescue_action(e) raise e end; end

class AttachmentControllerTest < Test::Unit::TestCase
  def setup
    @controller = AttachmentController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
