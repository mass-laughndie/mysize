require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:mysize1)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    post password_reset_path, params: { email: "" }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    post password_reset_path, params: { email: @user.email }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to confirm_password_reset_path
    user = assigns(:user)
    get edit_password_reset_path(rst: user.reset_token, e_token: "")
    assert_redirected_to root_url
    get edit_password_reset_path(rst: "", e_token: user.e_token)
    assert_redirected_to root_url
    get edit_password_reset_path(rst: user.reset_token, e_token: user.e_token)
    assert_template 'password_resets/edit'
    assert_select "input[name=e_token][type=hidden][value=?]", user.e_token
    patch password_reset_path, params: { e_token: user.e_token,
                                         rst: user.reset_token,
                                         user: { password: "foo",
                                                 password_confirmation: "bar" } }
    assert_select 'div.error'
    patch password_reset_path, params: { e_token: user.e_token,
                                         rst: user.reset_token,
                                         user: { password: "foobar",
                                                 password_confirmation: "foobar" } }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end
end
