class CommentsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :corrent_user,   only: :destroy

  def create
    @kickspost = Kickspost.find(params[:comment][:kickspost_id])
    @comment = @kickspost.comments.build(post_comment_params)
    if @comment.save
      #コメント通知作成
      @kickspost.user.notice_from(params[:kind], @comment)
      #返信通知作成
      msids = params[:comment][:comment_content].scan(/@[a-zA-Z0-9_]+\s/)
      if msids.any?
        msids.each do |msid|
          msid.delete!("@").delete!(" ")
          user = User.find_by(mysize_id: msid)
          if user && user != @kickspost.user
            user.notice_from("reply", @comment)
          end
        end
      end
      flash[:success] = "コメントを送信しました"
    else
      flash[:danger] = "コメントを送信できませんでした"
    end
    redirect_to kickspost_path(@kickspost.user.mysize_id, @kickspost)
  end

  def destroy
    @kickspost = Kickspost.find_by(id: @comment.kickspost_id)
    @kickspost.user.notice_delete("comment", @comment)
    @kickspost.user.notice_delete("reply", @comment)
    @comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_to kickspost_path(@kickspost.user.mysize_id, @kickspost)
  end


  private

    def post_comment_params
      params.require(:comment).permit(:user_id, :comment_content)
    end

    def corrent_user
      #自分のコメントor自分のポストへのコメントのみ
      @comment = current_user.comments.find_by(id: params[:id]) || current_user.kicksposts.find_by(id: params[:kickspost_id]).comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end

end
