class CommentsController < ApplicationController

  before_action :logged_in_user
  before_action :no_name
  before_action :corrent_user,   only: :destroy

  def create
    @kickspost = Kickspost.find_by(id: params[:comment][:kickspost_id])
    @comment = @kickspost.comments.build(post_comment_params)
    @user = @kickspost.user
    if @comment.save
      @comment.check_and_create_notice_to_others_and(@user, current_user)

=begin
      #自分のポストじゃないとき
      unless current_user?(@user)
        #コメント通知作成
        @user.receive_notice_of("Reply", @comment)
      end
=end
=begin
      #返信通知作成
      msids = params[:comment][:content].scan(/@[a-zA-Z0-9_]+\s/)
      if msids.any?
        msids.each do |msid|
          msid.delete!("@").delete!(" ")
          user = User.find_by(mysize_id: msid)
          if user && user != @user
            user.receive_notice_of("Reply", @comment)
          end
        end
      end
=end
      flash[:success] = "コメントを送信しました"
    else
      flash[:danger] = "コメントを送信できませんでした"
    end
    redirect_to kickspost_path(@user.mysize_id, @kickspost)
  end

  def destroy
    @kickspost = Kickspost.find_by(id: @comment.kickspost_id)
    @user = @kickspost.user

    @comment.check_and_delete_notice_form_others_and(@user, current_user)
    
=begin
    unless current_user?(@user)
      @user.lose_notice_of("Reply", @comment)
    end
    msids = @comment.content.scan(/@[a-zA-Z0-9_]+\s/)
    if msids.any?
      msids.each do |msid|
        msid.delete!("@").delete!(" ")
        user = User.find_by(mysize_id: msid)
        if user && user != @user
          user.lose_notice_of("Reply", @comment)
        end
      end
    end
=end
=begin
    Notice.where("kind IN (?) OR kind IN (?) OR kind IN (?)", "comment", "reply", "gcom_list")
          .where(kind_id: @comment.id).destroy_all
    Good.where(kind: "gcom", kind_id: @comment.id).destroy_all
=end

    @comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_to kickspost_path(@user.mysize_id, @kickspost)
  end


  private

    def post_comment_params
      params.require(:comment).permit(:user_id, :content)
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
