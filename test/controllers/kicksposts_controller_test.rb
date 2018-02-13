require 'test_helper'

class KickspostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @kickspost = kicksposts(:orange)
  end

  test "should redirect create when no logged in" do
    assert_no_difference 'Kickspost.count' do
      post upload_path, params: { kickspost: { content: "Lorem ipsum",
                                               picture: fixture_file_upload('test/fixtures/kicks1.jpg', 'image/jpg'),
                                               size: 7 } }
    end
    assert_redirected_to login_url
  end


  test "should reidrect destroy when not logged in" do
    assert_no_difference 'Kickspost.count' do
      delete kickspost_path(@kickspost.user, @kickspost)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong kickspost" do
    log_in_as(users(:mysize1))
    kickspost = kicksposts(:ants)
    assert_no_difference 'Kickspost.count' do
      delete kickspost_path(kickspost.user, kickspost)
    end
    assert_redirected_to root_url
  end
end
