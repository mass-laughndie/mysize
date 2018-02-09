class UsersController < ApplicationController

  before_action :admin_user, only: :admusrind

  def show
    @user = User.find_by(mysize_id: params[:mysize_id]) || User.find_by(email: params[:mysize_id])
    @kicksposts = @user.kicksposts
  end

  def new
    @user = User.new
  end

  def admusrind
    @users = User.all
  end

  def destroy
    User.find_by(mysize_id: params[:mysize_id]).destroy
    flash[:success] = "削除が完了しました"
    redirect_to admusrind_url
  end

  def create
    @user = User.new(user_params)
    
    file = params[:user][:images]
    @user.set_image(file)

    #passwordバリデーション有効化
    @user.validate_password = true

    if @user.save
      log_in @user
      flash[:success] = "登録が完了しました！"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :mysize_id,
                                 :password, :password_confirmation)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
end
