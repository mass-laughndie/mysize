require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { email: "user@invlid",
                                          mysize_id: "$",
                                          password: "foo",
                                          password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div.error'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: { user: { email: "user@example.com",
                                          mysize_id:             "mysize",
                                          password:              "password",
                                          password_confirmation: "password" } }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    follow_redirect!
    assert_template 'settings/welcome'
    assert_not flash.empty?
  end
end
