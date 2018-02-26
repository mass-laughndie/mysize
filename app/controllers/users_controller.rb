class UsersController < ApplicationController

  before_action :logged_in_user, only: [:admusrind, :following, :followers]
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
    @ausers = User.all
  end

  def index
    @users = User.all
    @ary = [];
    @users.each do |user|
      @ary << user.mysize_id
    end
    render layout: false
  end

  def destroy
    User.find_by(mysize_id: params[:mysize_id]).destroy
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
    @users = @user.following#.includes(:passive_relationships)
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find_by(mysize_id: params[:mysize_id])
    @users = @user.followers#.includes(:active_relationships)
    render 'show_follow'
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
