class KickspostsController < ApplicationController
  
  before_action :logged_in_user,          except: [:show]

  def show
    @kickspost = Kickspost.find_by(id: params[:id])
    @user = @kickspost.user
    redirect_to kickspost_path(@user, @kickspost) if @user.mysize_id != params[:mysize_id]

    @comments = @kickspost.comments.includes(:user, :goods, :replies).where(reply_id: 0)
    @text = "detail"
  end

  def new
    @kickspost = current_user.kicksposts.build
  end

  def create
    @kickspost = current_user.kicksposts.build(kickspost_params)
    if @kickspost.save
      @kickspost.create_notice_to_others_from(current_user) if @kickspost.is_reply?
      flash[:success] = "投稿に成功しました"
      redirect_to follow_url
    else
      render 'new'
    end
  end

  def edit
    @kickspost = Kickspost.find_by(id: params[:id])
    @user = @kickspost.user
    redirect_if_invalid(@user)
    redirect_to kickspost_path(@user, @kickspost) if @user.mysize_id != params[:mysize_id]
  end

  def update
    @kickspost = Kickspost.find_by(id: params[:id])
    @user = @kickspost.user
    redirect_if_invalid(@user)
    redirect_to kickspost_path(@user, @kickspost) and return if @user.mysize_id != params[:mysize_id]

    if @kickspost.update_attributes(kickspost_params)
      flash[:success] = "編集に成功しました"
      redirect_to follow_url
    else
      render 'edit'
    end
  end

  def destroy
    @kickspost = Kickspost.find_by(id: params[:id])
    @user = @kickspost.user
    redirect_if_invalid(@user) and return
    redirect_to kickspost_path(@user, @kickspost) and return if @user.mysize_id != params[:mysize_id]

    @kickspost.comments.each do |comment|
      comment.delete_notice_from_others_and(current_user, current_user) if comment.is_reply?
      comment.delete_comment_notice_from(current_user, current_user)
    end

    @kickspost.delete_notice_from_others_by(current_user) if @kickspost.is_reply?

    @kickspost.destroy
    flash[:danger] = "投稿を削除しました"
    redirect_to user_path(current_user, display: "square")
  end

  def gooders
    @post = Kickspost.find_by(id: params[:id])
    @main = @post
    @users = @post.gooders.all
    @url = gooders_kickspost_url(@post)
    render 'shared/gooders'
  end

  private

    def kickspost_params
      params.require(:kickspost).permit(:title, :color, :brand,
                                        :content, :picture,
                                        :picture_cache, :size)
    end

    def redirect_if_invalid(user)
      return if current_user?(user) || current_user.admin?
      flash[:danger] = "権限がありません"
      redirect_to(root_url) and return true
    end
end
