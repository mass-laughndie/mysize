require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mysize1)
    @other = users(:mysize2)
  end

  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should redirect following when nor logged in" do
    get following_user_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end
end
