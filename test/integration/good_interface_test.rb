require 'test_helper'

class GoodInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:mysize1)
    @other = users(:mysize2)
    log_in_as(@user)
    @kickspost = kicksposts(:ants)
    @comment = comments(:video)
  end

  test 'should good a kickspost standard way' do
    assert_difference '@user.active_goods.count', 1 do
      post goods_path, params: { post_id: @kickspost.id,
                                 post_type: "Kickspost",
                                 gooded_id: @other.id }
    end
  end

  test 'shoulc good a kickspost with Ajax' do
    assert_difference '@user.active_goods.count', 1 do
      post goods_path, xhr: true, params: { post_id: @kickspost.id,
                                            post_type: "Kickspost",
                                            gooded_id: @other.id }
    end
  end

  test 'should good a comment standard way' do
    assert_difference '@user.active_goods.count', 1 do
      post goods_path, params: { post_id: @comment.id,
                                 post_type: "Comment",
                                 gooded_id: @other.id }
    end
  end

  #要noticeへの対応
  test 'should good a comment with Ajax' do
    assert_difference '@user.active_goods.count', 1 do
      post goods_path, xhr: true, params: { post_id: @comment.id,
                                            post_type: "Comment",
                                            gooded_id: @other.id }
    end
  end

  test 'should ungood a kickspost standard way' do
    @user.good("Kickspost", @kickspost)
    good = @user.active_goods.find_by(post_type: "Kickspost", post_id: @kickspost.id)
    assert_difference '@user.active_goods.count', -1 do
      delete good_path(good)
    end
  end

  test 'should ungood a kickspost with Ajax' do
    @user.good("Kickspost", @kickspost)
    good = @user.active_goods.find_by(post_type: "Kickspost", post_id: @kickspost.id)
    assert_difference '@user.active_goods.count', -1 do
      delete good_path(good), xhr: true
    end
  end

  test 'should ungood a comment standard way' do
    @user.good("Comment", @comment)
    good = @user.active_goods.find_by(post_type: "Comment", post_id: @comment.id)
    assert_difference '@user.active_goods.count', -1 do
      delete good_path(good)
    end
  end

  test 'should ungood a comment with Ajax' do
    @user.good("Comment", @comment)
    good = @user.active_goods.find_by(post_type: "Comment", post_id: @comment.id)
    assert_difference '@user.active_goods.count', -1 do
      delete good_path(good), xhr: true
    end
  end

end
