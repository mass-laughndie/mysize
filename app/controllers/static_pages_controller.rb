class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @kicksposts = current_user.feed.includes(:user, {comments: :user}, {goods: :user}).reorder(updated_at: :desc)
    end
  end

  def latest
    if logged_in?
      @user = current_user
    else
      @user = nil
    end
    @kicksposts = Kickspost.includes(:user, {comments: :user}).reorder(updated_at: :desc)
  end

  def help
  end

  def about
  end

  def terms
  end

  def privacy
  end

end
