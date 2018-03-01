class RelationshipsController < ApplicationController

  before_action :logged_in_user

  def create
    @user = User.find(params[:followed_id])
    @relation = current_user.follow(@user)
    @user.notice_from(params[:kind], @relation)
    @user.week_notice_list("follow_list", @relation)
    respond_to do |format|
      format.html { redirect_to request.fullpath }
      format.js
    end
  end

  def destroy
    @relation = Relationship.find(params[:id])
    @user = @relation.followed
    current_user.unfollow(@user)
    @user.notice_delete("follow", @relation)
    @user.week_notice_list_delete("follow")
    respond_to do |format|
      format.html { redirect_to request.fullpath }
      format.js
    end
  end
end
