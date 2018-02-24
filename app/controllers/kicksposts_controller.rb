class KickspostsController < ApplicationController
  before_action :logged_in_user
  before_action :no_name
  before_action :set_and_check_kickspost, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @comments = @kickspost.comments.includes(:user).all
  end

  def new
    @kickspost = current_user.kicksposts.build
  end

  def create
    @kickspost = current_user.kicksposts.build(kicksposts_params)
    if @kickspost.save
      flash[:success] = "投稿に成功しました"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @kickspost.update_attributes(postscontent_params)
      flash[:success] = "編集に成功しました"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    @kickspost.destroy
    flash[:danger] = "投稿を削除しました"
    redirect_to user_path(current_user, display: "square")
  end

  private

    def kicksposts_params
      params.require(:kickspost).permit(:picture, :picture_cache, :size, :content)
    end

    def postscontent_params
      params.require(:kickspost).permit(:size, :content)
    end

    def set_and_check_kickspost
      @kickspost = Kickspost.find_by(id: params[:id])
      @user = User.find_by(id: @kickspost.user_id)
      @check = User.find_by(mysize_id: params[:mysize_id])
      if @user != @check
        not_found
        #redirect_to kickspost_path(@user.mysize_id, @kickspost.id)
      end
    end

    def ensure_correct_user
      if @kickspost.user_id != current_user.id
        flash[:danger] = "権限がありません"
        redirect_to root_url
      end
    end
end
