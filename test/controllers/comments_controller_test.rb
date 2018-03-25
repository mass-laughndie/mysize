require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  test "should redirect create when no logged in" do
    assert_no_difference 'Comment.count' do
      post postcomments_path
    end
    assert_redirected_to login_url
  end

  test "should reidirect destroy when no logged in" do
    assert_no_difference 'Comment.count' do
      delete postcomment_path(comments(:apple))
    end
    assert_redirected_to login_url
  end

end
