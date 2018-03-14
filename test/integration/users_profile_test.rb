require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:mysize1)
    log_in_as @user
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name + "(@" + @user.mysize_id + ")さん")
    assert_match @user.kicksposts.count.to_s, response.body
    @user.kicksposts.each do |post|
      #assert_match post.picture, response.body
      assert_match post.content, response.body
    end
  end
end
