require 'test_helper'

class SearchingTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:mysize2)
    @kickspost = kicksposts(:orange)
    @comment = comments(:apple)
  end
  
  test 'search interface' do
    get search_path
    assert_template 'searches/search'
    assert_select 'div.search-form'
    assert_select 'div.search-select', false
    assert_no_match @user.mysize_id, response.body
    assert_no_match @kickspost.content, response.body
    assert_no_match @comment.content, response.body
    #検索ヒット0
    get search_path(for: "user", keyword: "zzzzzzzzzzzzzz")
    assert_select 'div.search-select'
    assert_no_match @user.mysize_id, response.body
    assert_no_match @kickspost.content, response.body
    assert_no_match @comment.content, response.body
    assert_select 'div.no-post'
    get search_path(for: "post", keyword: "zzzzzzzzzzzzzz")
    assert_no_match @kickspost.content, response.body
    assert_select 'div.no-post'
    get search_path(for: "com", keyword: "zzzzzzzzzzzzzz")
    assert_no_match @comment.content, response.body
    assert_select 'div.no-post'
    #ユーザー検索(mysize_id)
    get search_path(for: "user", keyword: "user2")
    assert_select 'div.search-select'
    assert_match @user.mysize_id, response.body
    assert_no_match @kickspost.content, response.body
    assert_no_match @comment.content, response.body
    #ユーザー検索(name)
    get search_path(for: "user", keyword: "Mysize")
    assert_match @user.mysize_id, response.body
    #ユーザー検索(size)
    get search_path(for: "user", keyword: "25.0")
    assert_match @user.mysize_id, response.body
    #投稿検索(content)
    get search_path(for: "post", keyword: "orange")
    assert_no_match @user.mysize_id, response.body
    assert_match @kickspost.content, response.body
    assert_no_match @comment.content, response.body
    #投稿検索(size)
    get search_path(for: "post", keyword: "26.5")
    assert_match @kickspost.content, response.body
    #コメント検索(content)
    get search_path(for: "com", keyword: "apple")
    assert_no_match @user.mysize_id, response.body
    assert_no_match @kickspost.content, response.body
    assert_match @comment.content, response.body
  end
end
