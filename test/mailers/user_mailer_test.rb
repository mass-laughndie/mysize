require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:mysize1)
  end

  test "welcome" do
    mail = UserMailer.welcome(@user)
    assert_equal "Welcome to Mysize!!!",  mail.subject
    assert_equal ["noreply@mysize.net"],  mail.from
    assert_equal [@user.email],           mail.to
    # assert_select root_url,                mail.body.encoded
  end

  test "password_reset" do
    mail = UserMailer.password_reset(@user)
    assert_equal "パスワード再設定",          mail.subject
    assert_equal ["noreply@mysize.net"],  mail.from
    assert_equal [@user.email],           mail.to
    # assert_match @user.reset_token, mail.body.encoded
  end

end
