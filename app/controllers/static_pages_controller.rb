class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @kicksposts = current_user.feed.includes(:user, {comments: :user}).reorder(updated_at: :desc)
    end
  end

  def latest
    if logged_in?
      @user = current_user
    end
    @kicksposts = Kickspost.includes(:user, {comments: :user}).reorder(updated_at: :desc)
    #@comments = @kicksposts.find_by(id: params[:id]).comments.includes(:user).all
    #@comment  = @kickspost.comments.build(user_id: current_user.id) if current_user
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
