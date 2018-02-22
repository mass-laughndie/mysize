class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @kicksposts = current_user.feed.reorder(updated_at: :desc)
    end
  end

  def latest
    if logged_in?
      @user = current_user
    end
    @kicksposts = Kickspost.reorder(updated_at: :desc)
  end

  def help
  end

  def about
  end

  def terms
  end

  def privacy
  end

  def contact
  end
end
