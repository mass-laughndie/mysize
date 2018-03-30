require 'test_helper'

class ContactMailerTest < ActionMailer::TestCase

  def setup
    @contact = contacts(:contact1)
  end

  test "received_message" do
    mail = ContactMailer.received_message(@contact)
    mail.transport_encoding = "8bit"
    assert_equal "お問い合わせを受け取りました。(お問い合わせ番号 #{@contact.id})", mail.subject
    assert_equal ["noreply@mysize-sneakers.com"],  mail.from
    assert_equal ["mysize_sns@outlook.com"], mail.to
    #assert_match "Hi", mail.body.encoded
  end

end
