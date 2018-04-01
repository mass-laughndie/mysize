require 'test_helper'

class KickspostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:mysize1)
    @kickspost = @user.kicksposts.build(brand: "Nike",
                                        title: "Air max",
                                        color: "Royal",
                                        content: "Lorem ipsum",
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

  test "title should be present" do
    @kickspost.title = "    "
    assert_not @kickspost.valid?
  end

  test "brand should be at most 30 characters" do
    @kickspost.brand = "a" * 31
    assert_not @kickspost.valid?
  end

  test "brand should be present" do
    @kickspost.brand = "    "
    assert_not @kickspost.valid?
  end

  test "title should be at most 50 characters" do
    @kickspost.title = "a" * 51
    assert_not @kickspost.valid?
  end

  test "color should be present" do
    @kickspost.color = "    "
    assert_not @kickspost.valid?
  end

  test "color should be at most 30 characters" do
    @kickspost.color = "a" * 31
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
