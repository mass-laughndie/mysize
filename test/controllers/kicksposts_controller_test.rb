require 'test_helper'

class KickspostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @kickspost = kicksposts(:orange)
  end

  test "should redirect create when no logged in" do
    assert_no_difference 'Kickspost.count' do
      post kicksposts_path, params: { kickspost: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should reidrect destroy when not logged in" do
    assert_no_difference 'Kickspost.count' do
      delete kickspost_path(@kickspost)
    end
    assert_redirected_to login_url
  end
end
