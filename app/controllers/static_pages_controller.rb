class StaticPagesController < ApplicationController

  before_action :logged_in_user, only: :follow

  def home
    redirect_to latest_path if logged_in?
  end

  def latest
    @user = (logged_in? ? current_user : nil)
    @kicksposts = Kickspost.includes(:user, {comments: :user}, {goods: :gooder}).reorder(updated_at: :desc)
    @text = "short"
  end

  def follow
    if logged_in?
      @user = current_user
      @kicksposts = current_user.feed.includes(:user, {comments: :user}, {goods: :gooder}).reorder(updated_at: :desc)
      @text = "short"
    end
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
  end

  private

  def not_logged_in?
    !logged_in? && params[:about].in?(['on1', 'on2', 'on3'])
  end

end
