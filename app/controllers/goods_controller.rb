class GoodsController < ApplicationController
  
  before_action :logged_in_user

  def create
    @type = params[:post_type]
    if @type == "Kickspost"
      @post = Kickspost.find_by(id: params[:post_id])
    elsif @type == "Comment"
      @post = Comment.find_by(id: params[:post_id])
    end
    @good = current_user.good(@type, @post)

    unless current_user?(@post.user)
      @post.good_notice_create_or_update
    end

    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  def destroy
    @good = Good.find(params[:id])
    @type = @good.post_type
    @post = @good.post
    current_user.ungood(@type, @post)

    unless current_user?(@post.user)
      @post.good_notice_check_or_delete
    end

    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end
end
