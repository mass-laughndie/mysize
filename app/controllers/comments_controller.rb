class CommentsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :get_post, only: [:create, :destroy]
  before_action :corrent_user,   only: :destroy

  def create
    @comment = @kickspost.comments.build(post_comment_params)
    if @comment.save
      flash[:success] = "コメントを送信しました"
      redirect_to kickspost_path(@kickspost.user.mysize_id, @kickspost)
    else
      flash[:danger] = "コメントを送信できませんでした"
      render 'kicksposts/show'
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_to kickspost_path(@kickspost.user.mysize_id, @kickspost)
  end


  private

    def post_comment_params
      params.require(:comment).permit(:user_id, :comment_content)
    end

    def get_post
      @kickspost = Kickspost.find(params[:kickspost_id])
    end

    def corrent_user
      #自分のコメントor自分のポストへのコメントのみ
      @comment = current_user.comments.find_by(id: params[:id]) || current_user.kicksposts.find_by(id: params[:kickspost_id]).comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end

end
