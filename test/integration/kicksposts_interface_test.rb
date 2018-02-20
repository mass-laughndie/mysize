require 'test_helper'

class KickspostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mysize1)
    @kickspost = kicksposts(:orange)
  end

  test "create kickspost interface" do
    get upload_path
    assert_redirected_to login_path
    log_in_as(@user)
    get upload_path
    #コメントなし=>無効
    picture = fixture_file_upload('test/fixtures/kicks1.jpg', 'image/jpg')
    assert_no_difference 'Kickspost.count' do
      post upload_path, params: { kickspost: { content: "",
                                               picture: picture,
                                               size: 3 } }
    end
    assert_select 'div.error'
    #画像なし=>無効
    content = "This kickspost really ties the room together"
    assert_no_difference 'Kickspost.count' do
      post upload_path, params: { kickspost: { content: content,
                                               picture: "",
                                               size: 2 } }
    end
    assert_select 'div.error'
    #有効な送信
    assert_difference 'Kickspost.count', 1 do
      post upload_path, params: { kickspost: { content: content,
                                               picture: picture,
                                               size: 7 } }
    end
    assert_not flash.empty?
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # assert_match picture, response.body
    #投稿を削除
    get user_path(@user)
    assert_select 'i.fa-ellipsis-h'
    first_kickspost = @user.kicksposts.first
    assert_difference 'Kickspost.count', -1 do
      delete kickspost_path(first_kickspost.user, first_kickspost)
    end
    get user_path(users(:mysize2))
    assert_select 'i.fa-ellipsis-h', count: 0
  end

  test "update kickspost interface" do
    get edit_kickspost_path(@user, @kickspost)
    assert_redirected_to login_path
    log_in_as(@user)
    get edit_kickspost_path(@user, @kickspost)
    assert_template 'kicksposts/edit'
    content = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    patch kickspost_path(@user, @kickspost), params: { kickspost: { size: 7,
                                                                    content: "" } }
    assert_select 'div.error'
    assert_template 'kicksposts/edit'
    # patch kickspost_path(@user.mysize_id, @kickspost.id), params: { kickspost: { size: 7,
    #                                                                content: content } }
    #assert_not flash.empty?
    #assert_redirected_to root_url
    #follow_redirect!
    #assert_match content, response.body
  end
end
