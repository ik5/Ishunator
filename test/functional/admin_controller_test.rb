require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get recipients" do
    get :recipients
    assert_response :success
  end

end
