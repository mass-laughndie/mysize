class NoticesController < ApplicationController

  before_action :logged_in_user

  def show
    #全通知
    @notices   = current_user.notices.includes(:user)
    current_user.delete_past_notices_already_read(@notices)
    current_user.decrement!(:notice_count, by = current_user.notice_count)
    #全通知リスト
    @notice_lists = @notices.where("kind IN (?) OR kind IN (?) OR kind IN (?)", "follow_list", "comment", "reply").reorder(updated_at: :desc)

    #期間ごとのフォロワーの２重配列作成
    @follow_lists = @notices.where(kind: "follow_list")     #フォロー通知リスト
    @followers = []                                         #フォロワー格納配列
    @follow_lists.each do |list|  #list=>各フォロー通知リスト
      #リストを作成した週のfollow通知
      fnotice = Notice.where(kind: "follow", created_at: that_day(list.created_at))
      #リストを作成した週のrelationship
      relation = Relationship.where(id: fnotice.pluck(:kind_id))
      #relationからフォロワーを検索して新しい順に並べた配列をフォロワー格納配列へ
      @followers << User.where(id: relation.pluck(:follower_id)).order(created_at: :desc)
    end

    #フォロワー格納配列から週を指定するのに利用(全通知リストが最新順のため後ろの配列から表示)
    @num = 0

    # @comments  = Comment.where(id: @notices.where(kind: "comment").pluck(:kind_id)).order(created_at: :desc)
    # @replies   = Comment.where(id: @notices.where(kind: "reply").pluck(:kind_id)).order(created_at: :desc)
  end

  def create
  end

  def destroy
  end
end
