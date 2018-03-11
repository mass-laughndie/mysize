require 'test_helper'

class CommentsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:mysize1)
    @kickspost = kicksposts(:orange)
    @other_post = kicksposts(:tone)
    @comment = comments(:apple)
  end

  test "create comment interface" do
    get kickspost_path(@user, @kickspost)
    assert_redirected_to login_url
    log_in_as(@user)
    get kickspost_path(@user, @kickspost)
    #コメントなし
    assert_no_difference 'Comment.count' do
      post postcomments_path, params: { comment: { user_id: @user.id,
                                                   kickspost_id: @kickspost.id,
                                                   content: "" } }
    end
    assert_not flash.empty?
    #有効なコメント
    content = "Nice!!!!!!!!"
    assert_difference'Comment.count', 1 do
      post postcomments_path, params: { comment: { user_id: @user.id,
                                                   kickspost_id: @kickspost.id,
                                                   content: content } }
    end
    assert_not flash.empty?
    assert_redirected_to kickspost_path(@user, @kickspost)
    follow_redirect!
    assert_match content, response.body
    assert_match @comment.content, response.body
    #削除
    assert_select 'i.fa-trash', count: 2
    latest_comment = @user.comments.last
    assert_difference 'Comment.count', -1 do
      delete postcomment_path(latest_comment.id, kickspost_id: @kickspost.id)
    end
    assert_not flash.empty?
    assert_redirected_to kickspost_path(@user, @kickspost)
    follow_redirect!
    assert_match @comment.content, response.body
    assert_select 'i.fa-trash', count: 1
    assert_no_match content, response.body
  end
end
