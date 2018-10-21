class UsersController < ApplicationController

  before_action :logged_in_user, only: [:destroy, :admusrind,
                                        :following, :followers, :good]
  before_action :admin_user,     only: [:admusrind, :destroy]

  def show
    @user = User.find_by(mysize_id: params[:mysize_id])
    @kicksposts = @user.kicksposts.includes(:comments, :goods)
    @comments = @user.comments.includes(:goods)
    @points = @user.passive_goods.where.not(gooder_id: @user.id).size
    gon.mypageKicksposts = Kickspost.find_format_gon_params(@kicksposts.ids.uniq, @user)
    gon.currentInfo = {
      isLoggedIn: logged_in?,
      isPostPage: false
    }
  end

  def new
    @user = User.new
  end

  def admusrind
    @users = User.search(params[:keyword])
    @kicksposts = Kickspost.search(params[:keyword]).includes(:user, {comments: :user})
    @comments = Comment.search(params[:keyword]).includes(:user)
  end

  def index
    @users = User.all
    render layout: false
  end

  def destroy
    @user = User.find_by(mysize_id: params[:mysize_id])

    #関連コメント、ポストの削除対応(dependent: :destroyにかからないもの)
    @user.comments.each do |comment|
      comment.delete_notice_from_others_and(current_user, current_user) if comment.is_reply?
      comment.delete_comment_notice_from(current_user, current_user)
    end

    @user.kicksposts.each do |kickspost|
      kickspost.comments.each do |comment|
        comment.delete_notice_from_others_and(current_user, current_user) if comment.is_reply?
      comment.delete_comment_notice_from(current_user, current_user)
      end
      kickspost.delete_notice_from_others_and(current_user) if kickspost.is_reply?
    end

    @user.destroy
    flash[:success] = "削除が完了しました"
    redirect_to admusrind_path
  end

  def create
    @user = User.new(user_params)
    @user.validate_password = true
    @user.name = params[:user][:mysize_id]
    @user.size = 27.0

    if @user.save
      log_in @user
      @user.send_email(:welcome)
      flash[:success] = "登録が完了しました！"
      redirect_to welcome_path
    else
      render 'new'
    end
  end

  def following
    @title = "フォロー"
    @user = User.find_by(mysize_id: params[:mysize_id])
    @users = @user.following.order(updated_at: :desc)
    @url = following_user_url(@user)
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find_by(mysize_id: params[:mysize_id])
    @users = @user.followers.order(updated_at: :desc)
    @url = followers_user_url(@user)
    render 'show_follow'
  end

  def good
    @user = User.find_by(mysize_id: params[:mysize_id])
    @goods = @user.active_goods.includes(:gooded).order(updated_at: :desc)
    @points = @user.passive_goods.where.not(gooder_id: @user.id).size
  end

  
  private

    def user_params
      params.require(:user).permit(:email, :mysize_id, :name, :size,
                                   :password, :password_confirmation)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
end
