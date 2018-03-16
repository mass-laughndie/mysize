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

  test "should redirect good when not logged in" do
    get good_user_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect admurind when not logged in and admin user" do
    get admusrind_path
    assert_redirected_to login_url
    log_in_as(@user)
    get admusrind_path
    assert_redirected_to root_url
  end
end
