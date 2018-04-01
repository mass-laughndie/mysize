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
    brand = "Nike"
    title = "Air max"
    color = "Black toe"
    content = "This kickspost really ties the room together"
    picture = fixture_file_upload('test/fixtures/kicks1.jpg', 'image/jpg')
    #タイトルなし=>無効
    assert_no_difference 'Kickspost.count' do
      post upload_path, params: { kickspost: { title: "",
                                               brand: "",
                                               color: "",
                                               content: content,
                                               picture: picture,
                                               size: 3 } }
    end
    #コメントなし=>無効
    assert_no_difference 'Kickspost.count' do
      post upload_path, params: { kickspost: { title: title,
                                               brand: brand,
                                               color: color,
                                               content: "",
                                               picture: picture,
                                               size: 3 } }
    end
    assert_select 'div.error'
    #画像なし=>無効
    assert_no_difference 'Kickspost.count' do
      post upload_path, params: { kickspost: { title: title,
                                               brand: brand,
                                               color: color,
                                               content: content,
                                               picture: "",
                                               size: 2 } }
    end
    assert_select 'div.error'
    #有効な送信
    assert_difference 'Kickspost.count', 1 do
      post upload_path, params: { kickspost: { title: title,
                                               brand: brand,
                                               color: color,
                                               content: content,
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
    first_kickspost = @user.kicksposts.first
    assert_difference 'Kickspost.count', -1 do
      delete kickspost_path(first_kickspost.user, first_kickspost)
    end
    get user_path(users(:mysize2))
  end

  test "update kickspost interface" do
    get edit_kickspost_path(@user, @kickspost)
    assert_redirected_to login_path
    log_in_as(@user)
    get edit_kickspost_path(@user, @kickspost)
    assert_template 'kicksposts/edit'
    title = "Air max"
    content = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
    patch kickspost_path(@user, @kickspost), params: { kickspost: { size: 7,
                                                                    title: "",
                                                                    content: content } }
    assert_select 'div.error'
    assert_template 'kicksposts/edit'
    patch kickspost_path(@user, @kickspost), params: { kickspost: { size: 7,
                                                                    title: title,
                                                                    content: "" } }
    assert_select 'div.error'
    assert_template 'kicksposts/edit'
    patch kickspost_path(@user, @kickspost), params: { kickspost: { size: 7,
                                                                    title: title,
                                                                    content: content } }

    assert_not flash.empty?
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
  end
end
