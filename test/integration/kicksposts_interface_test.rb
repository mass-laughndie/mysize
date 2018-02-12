require 'test_helper'

class KickspostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:mysize1)
  end

  test "kickspost interface" do
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
  end
end
