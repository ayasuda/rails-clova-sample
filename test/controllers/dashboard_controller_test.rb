require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get dashboard" do
    sign_in users(:one)
    get dashboard_url
    assert_response :success
  end

end
