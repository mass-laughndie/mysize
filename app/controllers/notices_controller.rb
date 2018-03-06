class NoticesController < ApplicationController

  before_action :logged_in_user

  def show
    #全通知
    @notices   = current_user.notices.includes(:user)
    #既読済みの過去通知の削除
    current_user.delete_past_notices_already_read(@notices)

    urnotices = @notices.where.not(unread_count: 0)
    if urnotices.any?
      urnotices.each do |urnotice|
        urnotice.update_attribute(:unread_count, 0)
      end
    end

    #全通知リスト
    @notice_lists = @notices.where("kind LIKE (?) OR kind IN (?) OR kind IN (?)",
                                   "%_list%", "comment", "reply")
                            .reorder(updated_at: :desc)

    #期間ごとのフォロワーの２重配列作成
    @follow_lists = @notices.where(kind: "follow_list")     #フォロー通知リスト
    @followers = []                                         #フォロワー格納配列
    @fcounts = []
    @follow_lists.each do |list|  #list=>各フォロー通知リスト
      #リストを作成した週のrelationship(最新順)
      relations = current_user.passive_relationships.where(created_at: that_week(list.created_at)).order(created_at: :desc)
      #frelationshipがない場合(念のため、基本は事前にlistが削除されているためfalseになるはず)
      if relations.blank?
        list.destroy  #list削除
      else
        #期間内のフォロワーを新しい順に並べた配列をフォロワー格納配列へ
        @fcounts << relations.to_a.size
        @followers << User.find(relations.pluck(:follower_id).first(2))
      end
    end
    #フォロワー格納配列から週を指定するのに利用(全通知リストが最新順のため後ろの配列から表示)
    @fnum = 0

    #ポストごとのgoodの２重配列作成
    @gpost_lists = @notices.where(kind: "gpost_list")     #gpost通知リスト
    @gposters = []                                         #goodとした人を格納する配列
    @gpcounts = []
    @gpost_lists.each do |list|
      #postへのgood
      postgood = Good.where(kind: "gpost", kind_id: list.kind_id).order(created_at: :desc)
      if postgood.blank?
        list.destroy
      else
        @gpcounts << postgood.to_a.size
        @gposters << User.find(postgood.pluck(:user_id).first(2))
      end
    end
    @gpostnum = @gpcounts.size - 1

    #ポストごとのgoodの２重配列作成
    @gcom_lists = @notices.where(kind: "gcom_list")     #gpost通知リスト
    @gcomers = []                                         #goodとした人を格納する配列
    @gccounts = []
    @gcom_lists.each do |list|
      #postへのgood
      comgood = Good.where(kind: "gcom", kind_id: list.kind_id).order(created_at: :desc)
      if comgood.blank?
        list.destroy
      else
        @gccounts << comgood.to_a.size
        @gcomers << User.find(comgood.pluck(:user_id).first(2))
      end
    end
    @gcomnum = @gccounts.size - 1 
  end

  def create
  end

  def destroy
  end
end
