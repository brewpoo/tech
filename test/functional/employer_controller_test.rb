require File.dirname(__FILE__) + '/../test_helper'
require 'employer_controller'

# Re-raise errors caught by the controller.
class EmployerController; def rescue_action(e) raise e end; end

class EmployerControllerTest < Test::Unit::TestCase
  def setup
    @controller = EmployerController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
