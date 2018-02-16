class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_to confirm_password_reset_path
    else
      flash.now[:danger] = "そのメールアドレスは登録されていません"
      render 'new'
    end
  end

  def confirm
  end

  def edit
  end
end
