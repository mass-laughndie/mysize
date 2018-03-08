class CommentsController < ApplicationController

  before_action :logged_in_user, only: [:post_create, :post_destroy]
  before_action :corrent_user,   only: :post_destroy

  def post_create
    @kickspost = Kickspost.find(params[:comment][:kickspost_id])
    @comment = @kickspost.comments.build(post_comment_params)
    @user = @kickspost.user
    if @comment.save

      #自分のポストじゃないとき
      unless current_user.kicksposts.include?(@kickspost)
        #コメント通知作成
        @user.create_comment_notice(params[:kind], @comment)
        #通知カウント +1
        @user.increment!(:notice_count, by = 1)
      end
      #返信通知作成
      msids = params[:comment][:comment_content].scan(/@[a-zA-Z0-9_]+\s/)
      if msids.any?
        msids.each do |msid|
          msid.delete!("@").delete!(" ")
          user = User.find_by(mysize_id: msid)
          if user && user != @user
            user.create_comment_notice("reply", @comment)
            user.increment!(:notice_count, by = 1)
          end
        end
      end
      flash[:success] = "コメントを送信しました"
    else
      flash[:danger] = "コメントを送信できませんでした"
    end
    redirect_to kickspost_path(@user.mysize_id, @kickspost)
  end

  def post_destroy
    @kickspost = Kickspost.find_by(id: @comment.kickspost_id)
    @kickspost.user.delete_comment_notice("comment", @comment)
    @kickspost.user.delete_comment_notice("reply", @comment)
=begin
    Notice.where("kind IN (?) OR kind IN (?) OR kind IN (?)", "comment", "reply", "gcom_list")
          .where(kind_id: @comment.id).destroy_all
    Good.where(kind: "gcom", kind_id: @comment.id).destroy_all
=end
    @comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_to kickspost_path(@kickspost.user.mysize_id, @kickspost)
  end


  private

    def post_comment_params
      params.require(:comment).permit(:user_id, :comment_content)
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
