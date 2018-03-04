class GoodsController < ApplicationController
  before_action :logged_in_user

  def create
    if params[:kind] == "post"
      @model = Kickspost.find_by(id: params[:kind_id])
      @kind = params[:kind]
    else params[:kind] == "comment"
      @model = Comment.find_by(id: params[:kind_id])
      @kind = params[:kind]
    end
    @user = @model.user
    @good = current_user.good(@kind, @model)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  def destroy
    @good = Good.find(params[:id])
    @kind = @good.kind
    if @kind == "post"
      @model = Kickspost.find_by(id: @good.kind_id)
    elsif @kind == "comment"
      @model = Comment.find_by(id: @good.kind_id)
    end
    @user = @model.user
    current_user.ungood(@kind, @model)
    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end
end
