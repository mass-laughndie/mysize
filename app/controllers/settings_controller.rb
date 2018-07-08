class SettingsController < ApplicationController

  before_action :logged_in_user

  def welcome
  end

  def welcome_update
    current_user.validate_shoesize = true
    current_user.validate_name = true

    if twitter_linked? && current_user.update_attributes(profile_params)
      flash[:success] = "プロフィール登録が完了しました！"
      redirect_to latest_path
    elsif !twitter_linked? && current_user.update_attributes(omniauth_params)
      flash[:success] = "アカウント登録が完了しました！"
      redirect_to latest_path
    else
      current_user.reload if name_or_mysize_id_blank?
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
    current_user.validate_shoesize = true
    current_user.validate_name = true

    if current_user.update_attributes(profile_params)
      flash[:success] = "更新が完了しました！"
      redirect_to current_user
    else
      current_user.reload if params[:user][:name].blank?
      render 'profile'
    end
  end

  def email
  end

  def email_update
    if current_user.update(email_params)
      flash[:success] = "メールアドレスの更新に成功しました！"
      redirect_to account_settings_path
    else
      current_user.reload
      render 'email'
    end
  end

  def mysizeid
  end

  def mysizeid_update
    if current_user.update(mysizeid_params)
      flash[:success] = "MysizeIDの更新に成功しました！"
      current_user.reload
      redirect_to account_settings_path
    else
      current_user.reload
      render 'mysizeid'
    end
  end

  def password
  end

  def password_update
    current_user.validate_password = true
    
    if current_user.update_attributes(password_params)
      flash[:success] = "Passwordの変更が完了しました！"
      redirect_to account_settings_path
    else
      render 'password'
    end
  end

  def leave
  end

  def destroy
    if current_user.authenticate(params[:password]) && !current_user.admin?
      log_out
      current_user.destroy
      flash[:success] = "退会処理が完了しました。<br>ご利用ありがとうございました。"
      redirect_to root_url
    else
      flash[:danger] = (current_user.admin? ? "このアカウントは削除できません。" : "Passwordが間違っています。" )
      render 'leave'
    end
  end

  private

  def omniauth_params
    params.require(:user).permit(:name, :mysize_id, :size, :image, :image_cache)
  end

  def profile_params
    params.require(:user).permit(:name, :size, :image, :image_cache, :content)
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

  def name_or_mysize_id_blank?
    params[:user][:name].blank? || params[:user][:mysize_id].blank?
  end

  def twitter_linked?
    current_user.uid.nil?
  end
end
