class GoodsController < ApplicationController
  before_action :logged_in_user
  before_action :no_name

  def create
    @type = params[:post_type]
    if @type == "Kickspost"
      @post = Kickspost.find_by(id: params[:post_id])
    elsif @type == "Comment"
      @post = Comment.find_by(id: params[:post_id])
    end
    @good = current_user.good(@type, @post)


    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  def destroy
    @good = Good.find(params[:id])
    @type = @good.post_type
    @post = @good.post
=begin
    if @type == "Kickspost"
      @post = Kickspost.find_by(id: @good.post_id)
    elsif @type == "Comment"
      @post = Comment.find_by(id: @good.post_id)
    end
=end
    current_user.ungood(@type, @post)
=begin
    @user = @post.user
    unless @user == current_user
      @user.delete_good_notice(@kind, @model)
    end
=end
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end
end
