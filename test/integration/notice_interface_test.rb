require 'test_helper'

class NoticeInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:mysize1)
    @other = users(:mysize2)
    @kickspost = kicksposts(:orange)
    @comment = comments(:tau)
  end

  test "follow notice" do
    log_in_as(@other)
    assert_difference '@user.notices.count', 1 do
      post relationships_path, params: { follower_id: @other.id,
                                         followed_id: @user.id }
    end
  end

  test "good notice to my kickspost" do
    log_in_as(@other)
    assert_difference '@user.notices.count', 1 do
      assert_difference '@other.active_goods.count', 1 do
        post goods_path, params: { post_type: "Kickspost",
                                   post_id: @kickspost.id,
                                   gooded_id: @user.id }
      end
    end
  end

  test "good notice to my comment" do
    log_in_as(@other)
    assert_difference '@user.notices.count', 1 do
      assert_difference '@other.active_goods.count', 1 do
        post goods_path, params: { post_type: "Comment",
                                   post_id:   @comment.id,
                                   gooded_id: @user.id }
      end
    end
  end

  test "reply kickspost notice" do
    log_in_as(@other)
    title = "Air max 97"
    brand = "Nike"
    color = "Bred"
    content = "@user1 Wonderful!!"
    picture = fixture_file_upload('test/fixtures/kicks1.jpg', 'image/jpg')
    assert_difference '@user.notices.count', 1 do
      assert_difference '@other.kicksposts.count', 1 do
        post upload_path, params: { kickspost: { title: title,
                                                 brand: brand,
                                                 color: color,
                                                 content: content,
                                                 picture: picture,
                                                 size: 21.5 } }
      end
    end
    log_in_as(@user)
    get notice_path
    assert_match content, response.body

    log_in_as(@other)
    get user_path(@other)
    first_kickspost = @other.kicksposts.first
    assert_difference 'Kickspost.count', -1 do
      delete kickspost_path(@other, first_kickspost)
    end
  end

  test "normal comment notice for my kickspost" do
    log_in_as(@other)
    content = "Good!!!!!!!!"
    assert_difference '@user.notices.count', 1 do
      assert_difference '@other.comments.count', 1 do
        post postcomments_path, params: { comment: { kickspost_id: @kickspost.id,
                                                     reply_id: 0,
                                                     content: content } }
      end
    end
    log_in_as(@user)
    get notice_path
    assert_match content, response.body
  end

  test "reply comment notice for other's kickspost" do
    log_in_as(@other)
    content = "@user1 My favorite!"
    assert_difference '@user.notices.count', 1 do
      assert_difference '@other.comments.count', 1 do
        post postcomments_path, params: { comment: { kickspost_id: kicksposts(:van).id,
                                                     reply_id: 0,
                                                     content: content } }
      end
    end
    log_in_as(@user)
    get notice_path
    assert_match content, response.body
  end

end
