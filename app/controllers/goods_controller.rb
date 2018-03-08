class GoodsController < ApplicationController
  before_action :logged_in_user
  before_action :no_name

  def create
    @kind = params[:kind]
    if @kind == "gpost"
      @model = Kickspost.find_by(id: params[:kind_id])
    else @kind == "gcom"
      @model = Comment.find_by(id: params[:kind_id])
    end
    @good = current_user.good(@kind, @model)

    @user = @model.user
    unless @user == current_user
      @user.create_good_notice(@kind + "_list", @model)
    end

    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end

  def destroy
    @good = Good.find(params[:id])
    @kind = @good.kind
    if @kind == "gpost"
      @model = Kickspost.find_by(id: @good.kind_id)
    elsif @kind == "gcom"
      @model = Comment.find_by(id: @good.kind_id)
    end
    current_user.ungood(@kind, @model)

    @user = @model.user
    unless @user == current_user
      @user.delete_good_notice(@kind, @model)
    end

    respond_to do |format|
      format.html { redirect_to current_user }
      format.js
    end
  end
end
