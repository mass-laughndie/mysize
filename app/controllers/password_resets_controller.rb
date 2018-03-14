class PasswordResetsController < ApplicationController

  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user
      @user.create_reset_digest_and_e_token
      @user.send_password_reset_email
      redirect_to confirm_password_reset_path
    else
      if params[:email].blank?
        flash.now[:danger] = "メールアドレスを入力してください"
      else
        flash.now[:danger] = "そのメールアドレスは登録されていません"
      end
      render 'new'
    end
  end

  def confirm
  end

  def edit
  end

  def update
    @user.validate_password = true
    if @user.update_attributes(user_params)
      unless logged_in?
        log_in @user
      end
      @user.update_attributes(reset_digest: nil, e_token: nil)
      flash[:success] = "パスワードの再発行が完了しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(e_token: params[:e_token])
    end

    def valid_user
      unless (@user && @user.authenticated?(:reset, params[:rst]))
        flash[:danger] = "そのページへはアクセスできません"
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        @user.update_attributes(reset_digest: nil, e_token: nil)
        flash[:danger] = "パスワード再発行期限が切れています"
        redirect_to new_password_reset_url
      end
    end
end
