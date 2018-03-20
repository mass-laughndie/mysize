class CommentsController < ApplicationController

  before_action :logged_in_user
  before_action :no_name
  before_action :corrent_user,   only: :destroy

  def create
    @comment = current_user.comments.build(post_comment_params)
    @kickspost = Kickspost.find_by(id: params[:comment][:kickspost_id])
    @user = @kickspost.user
    if @comment.save
      @comment.check_and_create_notice_to_others_and(@user, current_user)

      flash[:success] = "コメントを送信しました"
    else
      flash[:danger] = "コメントを送信できませんでした"
    end

    if params[:display]
      redirect_to kickspost_path(@user.mysize_id, @kickspost, display: params[:display])
    else
      redirect_to kickspost_path(@user.mysize_id, @kickspost)
    end
  end

  def destroy
    @kickspost = Kickspost.find_by(id: @comment.kickspost_id)
    @user = @kickspost.user

    @comment.check_and_delete_notice_form_others_and(@user, current_user)
    
=begin
    Notice.where("kind IN (?) OR kind IN (?) OR kind IN (?)", "comment", "reply", "gcom_list")
          .where(kind_id: @comment.id).destroy_all
    Good.where(kind: "gcom", kind_id: @comment.id).destroy_all
=end

    @comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_to kickspost_path(@user.mysize_id, @kickspost, display: "text")
  end


  private

    def post_comment_params
      params.require(:comment).permit(:kickspost_id, :reply_id, :content)
    end

    def corrent_user
      if current_user.admin?
        @comment = Comment.find_by(id: params[:id])
      else
        #自分のコメントor自分のポストへのコメントのみ
        @comment = current_user.comments.find_by(id: params[:id]) || current_user.kicksposts.find_by(id: params[:kickspost_id]).comments.find_by(id: params[:id])
        redirect_to root_url if @comment.nil?
      end
    end

end
