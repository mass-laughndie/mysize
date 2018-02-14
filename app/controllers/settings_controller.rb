class SettingsController < ApplicationController

  before_action :logged_in_user
  before_action :get_user

  def welcome
  end

  def welcome_update
    @user.validate_shoesize = true
    @user.validate_name = true
    unless @user.uid.nil?
      @user.validate_password = true
    end
    if @user.uid.nil? && @user.update_attributes(profile_params)
      flash[:success] = "プロフィール登録が完了しました！"
      redirect_to @user
    elsif !@user.uid.nil? && @user.update_attributes(omniauth_params)
      flash[:success] = "アカウント登録が完了しました！"
      redirect_to @user
    else
      if params[:user][:name].blank? || params[:user][:mysize_id].blank?
        @user.reload
      end
      render 'welcome'
    end
  end

  def option
  end

  def account
  end

  def profile
  end

  def profile_update
    @user.validate_shoesize = true
    @user.validate_name = true
    if @user.update_attributes(profile_params)
      flash[:success] = "更新が完了しました！"
      redirect_to @user
    else
      if params[:user][:name].blank?
        @user.reload
      end
      render 'profile'
    end
  end

  def email
  end

  def email_update
    if @user.update(email_params)
      flash[:success] = "メールアドレスの更新に成功しました！"
      redirect_to account_settings_path
    else
      @user.reload
      render 'email'
    end
  end

  def mysizeid
  end

  def mysizeid_update
    if @user.update(mysizeid_params)
      flash[:success] = "MysizeIDの更新に成功しました！"
      @user.reload
      redirect_to account_settings_path
    else
      @user.reload
      render 'mysizeid'
    end
  end

  def password
  end

  def password_update
    @user.validate_password = true
    if @user.authenticate(params[:password])
      if @user.update_attributes(password_params)
        flash[:success] = "Passwordの変更が完了しました！"
        redirect_to account_settings_path
      else
        render 'password'
      end
    else
      flash.now[:danger] = "Passwordが間違っています。"
      render 'password'
    end
  end

  def leave
  end

  def destroy
    if @user.authenticate(params[:password]) && !@user.admin?
      log_out
      @user.destroy
      flash[:success] = "退会が完了しました。ご利用ありがとうございました。"
      redirect_to root_url
    else
      if @user.admin?
        flash[:danger] = "このアカウントは削除できません。"
      else
        flash[:danger] = "Passwordが間違っています。"
      end
      render 'leave'
    end
  end

  private

    def omniauth_params
      params.require(:user).permit(:name, :mysize_id, :shoe_size,
                                   :password, :password_confirmation)
    end

    def profile_params
      params.require(:user).permit(:name, :shoe_size, :image,
                                   :image_cache, :profile_content)
    end

    def email_params
      params.require(:user).permit(:email)
    end

    def mysizeid_params
      params.require(:user).permit(:mysize_id)
    end

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = current_user
    end
end
