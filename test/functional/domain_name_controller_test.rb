require File.dirname(__FILE__) + '/../test_helper'
require 'domain_name_controller'

# Re-raise errors caught by the controller.
class DomainNameController; def rescue_action(e) raise e end; end

class DomainNameControllerTest < Test::Unit::TestCase
  def setup
    @controller = DomainNameController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
