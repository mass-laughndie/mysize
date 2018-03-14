require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:mysize1)
    @kickspost = kicksposts(:orange)
    @comment = @kickspost.comments.build(user_id: @user.id,
                                         content: "Nice shoes!!!")
  end

  test 'should be valid' do
    assert @comment.valid?
  end
  
  test 'should require a user_id' do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test 'should require a kickspost_id' do
    @comment.kickspost_id = nil
    assert_not @comment.valid?
  end

  test 'should require a content' do
    @comment.content = "    "
    assert_not  @comment.valid?
  end

  test 'content should be present less than 501 characters' do
    @comment.content = "a" * 501
    assert_not @comment.valid?
  end

end
