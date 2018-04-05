class SessionsController < ApplicationController

  before_action :logged_in, only: [:new]

  def new
  end

  def create
    @user = User.find_by(mysize_id: params[:mysize_id].downcase) || User.find_by(email: params[:mysize_id].downcase)
    if @user && @user.authenticate(params[:password])
      log_in @user
      #常時remember me状態
      remember @user
      flash[:success] = "ログインに成功しました！"
      redirect_to latest_path
    else
      flash.now[:danger] = "Mysize_id/メールアドレス<br>またはPasswordが間違っています。"
      render 'new'
    end
  end

  def omniauth_create
    @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
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

    def logged_in
      if logged_in?
        flash[:info] = "既にログイン中です"
        redirect_to latest_url
      end
    end

end
