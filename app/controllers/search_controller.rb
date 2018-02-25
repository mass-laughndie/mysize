class SearchController < ApplicationController

  def search
    @users = User.search(params[:search])
    @kicksposts = Kickspost.search(params[:search]).includes(:user, {comments: :user})

=begin
    @history ||= []

    #検索履歴
    unless params[:search].blank?　
      @history << params[:search]
    end

    #検索履歴削除
    if params[:history] == "clear"
      @history.clear
    end
=end
  end
end
