require 'test_helper'

class ContactTest < ActiveSupport::TestCase

  def setup
    @contact = Contact.new(name: "画像のアップロードができない",
                           email: "user1@example.com",
                           message: "画像がアップロードできません。どうしたらよいでしょうか？")
  end

  test 'should be valid' do
    assert @contact.valid?
  end

  test 'should name not be blank' do
    @contact.name = nil
    assert_not @contact.valid?
  end

  test 'should name less than 256 characters' do
    @contact.name = 'a' * 256
    assert_not @contact.valid?
  end

  test 'should email not be blank' do
    @contact.email = nil
    assert_not @contact.valid?
  end


  test 'should email not user invalid charcters' do
    @contact.email = "invalid.com"
    assert_not @contact.valid?
  end

  test 'should email less than 256 characters' do
    @contact.email = 'a' * 244 + '@example.com'
    assert_not @contact.valid?
  end
  test 'should message not be blank' do
    @contact.message = nil
    assert_not @contact.valid?
  end

  test 'should message less than 2001 characters' do
    @contact.message = 'a' * 2001
    assert_not @contact.valid?
  end

end
