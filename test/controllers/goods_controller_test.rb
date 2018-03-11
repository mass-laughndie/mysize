require 'test_helper'

class GoodsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:mysize1)
    @kickspost = kicksposts(:orange)
    @comment = comments(:apple)
  end

  test "should redirect create when no logged in" do
    assert_no_difference 'Good.count' do
      post goods_path
    end
    assert_redirected_to login_url
  end

  test "should reidrect destroy when no logged in" do
    assert_no_difference 'Good.count' do
      delete good_path(goods(:good1))
    end
    assert_redirected_to login_url
  end

end
