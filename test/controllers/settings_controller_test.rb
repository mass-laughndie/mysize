require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:mysize1)
    log_in_as(@user)
  end
  
  test "should get account" do
    get account_settings_path
    assert_response :success
  end

  test "should get profile" do
    get profile_settings_path
    assert_response :success
  end

  test "should get email" do
    get email_settings_path
    assert_response :success
  end

  test "should get mysizeid" do
    get mysizeid_settings_path
    assert_response :success
  end

  test "should get password" do
    get password_settings_path
    assert_response :success
  end

end
