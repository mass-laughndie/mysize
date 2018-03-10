class UsersController < ApplicationController

  before_action :logged_in_user, only: [:destroy, :admusrind,
                                        :following, :followers, :good]
  before_action :admin_user,     only: :admusrind

  def show
    @user = User.find_by(mysize_id: params[:mysize_id])
    if current_user == @user
      no_name
    end
    @kicksposts = @user.kicksposts.includes(:comments)
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

    @user.comments.each do |comment|
      comment.check_and_create_notice_to_others_and(current_user, current_user)
      # Good.where(kind: "gcom", kind_id: comment.id).destroy_all
    end

    @user.kicksposts.each do |kickspost|
      kickspost.comments.each do |comment|
        comment.check_and_delete_notice_form_others_and(current_user, current_user)
        # Good.where(post_type: "Comment", post_id: comment.id).destroy_all
      end
      kickspost.check_and_delete_notice_form_others_and(current_user)
      # Good.where(post_type: "Kickspost", post_id: kickspost.id).destroy_all
    end
=begin
    @user.goods.each do |good|
      Notice.find_by(kind: good.kind + "_list", kind_id: good.kind_id).destroy
    end
=end
    @user.destroy
    flash[:success] = "削除が完了しました"
    redirect_to admusrind_url
  end

  def create
    @user = User.new(user_params)
    #passwordバリデーション有効化
    @user.validate_password = true

    if @user.save
      log_in @user
      @user.send_welcome_email
      flash[:success] = "登録が完了しました！"
      redirect_to welcome_path
    else
      render 'new'
    end
  end

  def following
    @title = "フォロー"
    @user = User.find_by(mysize_id: params[:mysize_id])
    @users = @user.following.order(updated_at: :desc)#.includes(:passive_relationships)
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find_by(mysize_id: params[:mysize_id])
    @users = @user.followers.order(updated_at: :desc)#.includes(:active_relationships)
    render 'show_follow'
  end

  def good
    @user = User.find_by(mysize_id: params[:mysize_id])
    @goods = @user.goods.order(updated_at: :desc)
  end

  
  private

    def user_params
      params.require(:user).permit(:email, :mysize_id,
                                   :password, :password_confirmation)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
end
