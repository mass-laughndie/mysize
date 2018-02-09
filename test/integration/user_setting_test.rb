require 'test_helper'

class UserSettingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mysize1)
    log_in_as(@user)
  end

  test "unsuccessful edit mysizeID" do
    get account_settings_path
    assert_template 'settings/account'
    get mysizeid_settings_path
    assert_template 'settings/mysizeid'
    patch mysizeid_settings_path, params: { user: { mysize_id: "" } }
    @user.reload
    assert_template 'settings/mysizeid'
  end

  test "successful edit mysizeID" do
    get mysizeid_settings_path
    patch mysizeid_settings_path, params: { user: { mysize_id: "mysize2" } }
    assert_not flash.empty?
    assert_redirected_to account_settings_path
  end

  test "unsuccessful edit email" do
    get email_settings_path
    assert_template 'settings/email'
    patch email_settings_path, params: { user: { email: "" } }
    assert_template 'settings/email'
  end

  test "successful edit email" do
    get email_settings_path
    patch email_settings_path, params: { user: { email: "mysize3@example.com" } }
    follow_redirect!
    assert_template 'settings/account'
  end

  test "unsuccessful edit password" do
    get password_settings_path
    assert_template 'settings/password'
    patch password_settings_path, params: { password: "",
                                            user: { password: "foobar",
                                                      password_confirmation: "foobar" } }
    assert_not flash.empty?
    assert_template 'settings/password'
    patch password_settings_path, params: { password: "password",
                                            user: { password: "foo",
                                                    password_confirmation: "bar" } }
    assert_template 'settings/password'
  end

  test "successful edit password" do
    get password_settings_path
    assert_template 'settings/password'
    patch password_settings_path, params: { password: "password",
                                            user: { password: "foobar",
                                                    password_confirmation: "foobar" } }
    assert_not flash.empty?
    assert_redirected_to account_settings_path
  end

  test "unsuccessful edit profile" do
    get profile_settings_path
    assert_template 'settings/profile'
    patch profile_settings_path, params: { user: { name: "", 
                                                   shoe_size: 1,
                                                   image: nil,
                                                   profile_content: "" } }
    assert flash.empty?
    assert_template 'settings/profile'
  end

  test "successful edit profile" do
    get profile_settings_path
    assert_template 'settings/profile'
    patch profile_settings_path, params: { user: { name: "mysize1", 
                                                   shoe_size: 1,
                                                   image: nil,
                                                   profile_content: "AirMax(26.5cm)" } }
    assert_not flash.empty?
    assert_redirected_to @user
  end
  
end
