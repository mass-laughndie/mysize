class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:follow, :follow_square]
  before_action :setting_gon, only: [:latest, :follow, :follow_square]

  def home
    redirect_to latest_path if logged_in?
  end

  def latest
    @user = (logged_in? ? current_user : nil)
    @kicksposts = Kickspost.includes(:user, {comments: :user}, {goods: :gooder}).reorder(updated_at: :desc)
    @text = "short"
    gon.latestKicksposts = Kickspost.find_format_gon_params(@kicksposts.ids.uniq, @user)
    gon.currentUser = User.find_format_gon_params_by(@user&.id)
  end

  def follow
    @user = current_user
    @kicksposts = current_user.feed.includes(:user, {comments: :user}, {goods: :gooder}).reorder(updated_at: :desc)
    @text = "short"
    gon.followingKicksposts = Kickspost.find_format_gon_params(@kicksposts.ids.uniq, @user)
    gon.currentUser = User.find_format_gon_params_by(@user&.id)
  end

  def follow_square
    @user = current_user
    @kicksposts = current_user.feed.includes(:user, {comments: :user}, {goods: :gooder}).reorder(updated_at: :desc)
    @text = "short"
    gon.followingKicksposts = Kickspost.find_format_gon_params(@kicksposts.ids.uniq, @user)
    gon.currentUser = User.find_format_gon_params_by(@user&.id)
  end

  def help
  end

  def about
    flash.now[:danger] = "ログインまたは登録をお願いします。" if not_logged_in?
  end

  def terms
  end

  def privacy
  end

  def test
    gon.test = "Test!!!"
  end

  private

  def not_logged_in?
    !logged_in? && params[:about].in?(['on1', 'on2', 'on3'])
  end

  def setting_gon
    gon.currentInfo = {
      isLoggedIn: logged_in?,
      isPostPage: false
    }
  end
end
