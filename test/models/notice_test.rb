require 'test_helper'

class NoticeTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:mysize1)
    @kickspost = kicksposts(:orange)
    @comment = comments(:apple)
    @notice1 = @kickspost.create_notice(user_id: @user.id)
    @notice2 = @comment.create_notice(user_id: @user.id)
  end

  test "should be valid" do
    assert @notice1.valid?
    assert @notice2.valid?
  end

  test "should require a user_id" do
    @notice1.user_id = nil
    assert_not @notice1.valid?
  end

  test "should require a kind_id" do
    @notice1.kind_id = nil
    assert_not @notice1.valid?
  end

  test "should require a kind_type" do
    @notice1.kind_type = nil
    assert_not @notice1.valid?
  end
end
