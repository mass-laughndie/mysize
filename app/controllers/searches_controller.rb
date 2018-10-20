class SearchesController < ApplicationController

  def search
    @users = User.search(params[:keyword])
    @kicksposts = Kickspost.search(params[:keyword]).includes(:user, {comments: :user})
    @comments = Comment.search(params[:keyword]).includes(:user)
    gon.searchKicksposts = Kickspost.find_format_gon_params(@kicksposts.ids.uniq, logged_in? ? current_user : nil) if params[:for] == "post"
    gon.searchComments = Comment.find_format_gon_params(@comments.ids.uniq, logged_in? ? current_user : nil) if params[:for] == "com"
    gon.logged_in = logged_in?
  end
  
end
