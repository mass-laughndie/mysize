class SessionsController < ApplicationController
  before_action :logged_in, only: :new

  def new
  end

  def create
    @user = find_user_by(params[:mysize_id])

    if @user && @user.authenticate(params[:password])
      log_in @user
      remember @user                                    #常時remember me状態
      flash[:success] = "ログインに成功しました！"
      redirect_to latest_path
    else
      flash.now[:danger] = "Mysize_id/メールアドレス<br>またはPasswordが間違っています。"
      render 'new'
    end
  end

  def omniauth_create
    @user = ExternalSigninUser.find_or_create_from_auth(auth_params)
    log_in @user
    remember @user

    if @user.created_at > 1.minutes.ago
      flash[:success] = "登録が完了しました"
      redirect_to welcome_url
    else
      flash[:success] = "ログインに成功しました！"
      redirect_to latest_url
    end
  end

  def destroy
    if logged_in?
      log_out
      flash[:success] = "ログアウトしました！"
    end
    redirect_to root_url
  end

  private

  def auth_params
    request.env['omniauth.auth']
  end

  def logged_in
    return unless logged_in?
    flash[:info] = "既にログイン中です"
    redirect_to latest_url
  end

  def find_user_by(param)
    User.find_by(mysize_id: param.downcase) || User.find_by(email: param.downcase)
  end
end
