class GoodsController < ApplicationController
  
  before_action :logged_in_user

  def create
    @post = find_target_post_by(params[:post_type])
    @good = current_user.good(params[:post_type], @post)

    @post.good_notice_create_or_update unless current_user?(@post.user)

    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
      format.json { render :json => @good }
    end
  end

  def destroy
    @good = Good.find(params[:id])
    @post = @good.post
    current_user.ungood(@good.post_type, @post)

    @post.good_notice_check_or_delete unless current_user?(@post.user)

    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  private

  def find_target_post_by(type)
    redirect_to current_user unless valid_post_type.include?(type)
    klass = (type == "Kickspost") ? Kickspost : Comment
    klass.find_by(id: params[:post_id])
  end

  def valid_post_type
    ["Kickspost", "Comment"]
  end
end
