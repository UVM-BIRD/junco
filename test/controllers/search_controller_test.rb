require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get results" do
    get :journals
    assert_response :success
  end

end
