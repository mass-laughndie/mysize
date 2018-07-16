class PasswordResetsController < ApplicationController
  def new
  end

  def create
    if @user = User.find_by(email: params[:email].downcase)
      @user.create_reset_digest_and_e_token
      @user.send_email(:password_reset)
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
    @user = User.find_by(e_token: params[:e_token])
    redirect_if_invalid(@user) and return
    redirect_if_expired_password_reset_for(@user) and return
  end

  def update
    @user = User.find_by(e_token: params[:e_token])
    redirect_if_invalid(@user) and return
    redirect_if_expired_password_reset_for(@user) and return

    @user.validate_password = true
    if @user.update_attributes(user_params)
      log_in @user unless logged_in?
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

    def redirect_if_invalid(user)
      return if user && user.authenticated?(:reset, params[:rst])
      flash[:danger] = "そのページへはアクセスできません"
      redirect_to root_url and return true
    end

    def redirect_if_expired_password_reset_for(user)
      return unless user && user.password_reset_expired?
      user.update_attributes(reset_digest: nil, e_token: nil)
      flash[:danger] = "パスワード再発行期限が切れています"
      redirect_to new_password_reset_url and return true
    end
end
