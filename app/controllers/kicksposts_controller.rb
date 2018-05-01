class KickspostsController < ApplicationController
  
  before_action :logged_in_user,          except: [:show]
  before_action :set_and_check_kickspost, only:   [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user,     only:   [:edit, :update, :destroy]

  def show
    @comments = @kickspost.comments.includes(:user, :goods, :replies).where(reply_id: 0)
    @text = "detail"
  end

  def new
    @kickspost = current_user.kicksposts.build
  end

  def create
    @kickspost = current_user.kicksposts.build(kicksposts_params)
    if @kickspost.save
      @kickspost.check_and_create_notice_to_others_and(current_user)
      flash[:success] = "投稿に成功しました"
      redirect_to follow_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @kickspost.update_attributes(kicksposts_params)
      flash[:success] = "編集に成功しました"
      redirect_to follow_url
    else
      render 'edit'
    end
  end

  def destroy
    @kickspost.comments.each do |comment|
      comment.check_and_delete_notice_form_others_and(current_user, current_user)
    end

    @kickspost.check_and_delete_notice_form_others_and(current_user)

    @kickspost.destroy
    flash[:danger] = "投稿を削除しました"
    redirect_to user_path(current_user, display: "square")
  end

  def gooders
    @post = Kickspost.find_by(id: params[:id])
    @main = @post
    @users = @post.gooders.all
    @url = gooders_kickspost_url(@post)
    render 'shared/gooders'
  end

  private

    def kicksposts_params
      params.require(:kickspost).permit(:title, :color, :brand,
                                        :content, :picture,
                                        :picture_cache, :size)
    end

    def set_and_check_kickspost
      @kickspost = Kickspost.find_by(id: params[:id])
      @user = User.find_by(id: @kickspost.user_id)
      @check = User.find_by(mysize_id: params[:mysize_id])

      if @user != @check
        not_found
        #redirect_to kickspost_path(@user, @kickspost.id)
      end
    end

    def ensure_correct_user
      unless @kickspost.user_id == current_user.id || current_user.admin?
        flash[:danger] = "権限がありません"
        redirect_to root_url
      end
    end
end
