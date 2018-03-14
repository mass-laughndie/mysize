require 'test_helper'

class KickspostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:mysize1)
    @kickspost = @user.kicksposts.build(content: "Lorem ipsum",
                                        picture: open("#{Rails.root}/db/data/kicks1.jpg"),
                                        size: 7)
  end

  test "should be valid" do
    assert @kickspost.valid?
  end

  test "user id should be present" do
    @kickspost.user_id = nil
    assert_not @kickspost.valid?
  end

  test "content should be present" do
    @kickspost.content = "    "
    assert_not @kickspost.valid?
  end

  test "content should be at most 500 characters" do
    @kickspost.content = "a" * 501
    assert_not @kickspost.valid?
  end

  test "order should be most recent first" do
    assert_equal kicksposts(:most_recent), Kickspost.first
  end
end
