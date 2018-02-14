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
      redirect_back_or @user
    else
      flash.now[:danger] = "Mysize_id/メールアドレスかPasswordが間違っています。"
      render 'new'
    end
  end

  def omniauth_create
    @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    log_in @user
    flash[:success] = "ログインに成功しました！"
    redirect_back_or root_url
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
        redirect_to root_url
      end
    end

end
