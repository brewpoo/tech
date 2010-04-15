require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/ipv4_schema_rule_controller'

# Re-raise errors caught by the controller.
class Admin::Ipv4SchemaRuleController; def rescue_action(e) raise e end; end

class Admin::Ipv4SchemaRuleControllerTest < Test::Unit::TestCase
  def setup
    @controller = Admin::Ipv4SchemaRuleController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
