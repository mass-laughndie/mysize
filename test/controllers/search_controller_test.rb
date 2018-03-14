require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  
  test "should get search" do
    get search_path
    assert_response :success
  end

  test "should get search for user" do
    get search_path(keywrod: "")
    assert_response :success
  end

  test "should get search for kickspost" do
    get search_path(for: "post", keywrod: "")
    assert_response :success
  end

  test "should get search for comment" do
    get search_path(for: "comment", keywrod: "")
    assert_response :success
  end

end
