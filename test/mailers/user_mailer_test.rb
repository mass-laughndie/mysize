require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:mysize1)
  end

  test "welcome" do
    mail = UserMailer.welcome(@user)
    mail.transport_encoding = "8bit"
    assert_equal "Welcome to Mysize!!!",  mail.subject
    assert_equal ["noreply@mysize.net"],  mail.from
    assert_equal [@user.email],           mail.to
    # assert_match root_url,               mail.body.encoded
  end

  test "password_reset" do
    @user.reset_token = User.new_token
    @user.e_token = User.digest(@user.email)
    mail = UserMailer.password_reset(@user)
    mail.transport_encoding = "8bit"
    assert_equal "パスワード再設定URL発行",    mail.subject
    assert_equal ["noreply@mysize.net"],  mail.from
    assert_equal [@user.email],           mail.to
    # assert_match @user.reset_token,       mail.body.encoded
    # assert_match @user.e_token,           mail.body.encoded
  end

end
