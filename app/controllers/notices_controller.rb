class NoticesController < ApplicationController

  before_action :logged_in_user
  before_action :no_name

  def show
    #全通知
    @notices   = current_user.notices.includes(:user)
    #既読済みの過去通知の削除
    current_user.delete_past_notices_already_read(@notices)

    #未読数リセット
    urnotices = @notices.where.not(unread_count: 0)
    if urnotices.any?
      urnotices.each do |urnotice|
        urnotice.decrement!(:unread_count, urnotice.unread_count)
      end
    end

    #期間ごとのフォロワーの２重配列作成
    follow_notices = @notices.where(kind_type: "Follow")     #フォロー通知リスト
    @followers = []                                         #フォロワー格納配列
    @fcounts = []
    follow_notices.each do |notice|  #notice=>各フォロー通知リスト
      #リストを作成した週のrelationship(最新順)
      relations = current_user.passive_relationships.where(created_at: that_day(notice.created_at)).order(created_at: :desc)
      #frelationshipがない場合(念のため、基本は事前にnoticeが削除されているためfalseになるはず)
      if relations.blank?
        notice.destroy  #list削除
      else
        #期間内のフォロワーを新しい順に並べた配列をフォロワー格納配列へ
        @fcounts.unshift(relations.to_a.size)
        @followers.unshift(User.find(relations.pluck(:follower_id).first(2)))
      end
    end
    #フォロワー格納配列から週を指定するのに利用(全通知リストが最新順のため後ろの配列から表示)
    @fnum = @fcounts.size - 1 

    #その他の通知関連
    @posts = []               #post配列
    @gcommers = []            #comments.gooders配列
    @gposters = []            #kicksposts.gooders配列
    #各配列のindexnumber
    @pnum  = 0
    @gcnum = 0
    @gpnum = 0
    @notices.each do |notice|
      ntype = notice.kind_type
      if ntype.in?(["ReplyCom", "NormalCom"])
        unless post = Comment.find_by(id: notice.kind_id)
          notice.destroy
        else
          @posts << post
        end
      elsif ntype == "Comment"
        unless post = notice.kind
          notice.destroy
        else
          gooder = notice.kind.gooders.where.not(id: current_user.id)
          if gooder.blank?
            notice.destroy
          else
            @gcommers << gooder
            @posts << post
          end
        end
      elsif ntype == "ReplyPost"
        unless post = Kickspost.find_by(id: notice.kind_id)
          notice.destroy
        else
          @posts << post
        end
      elsif ntype == "Kickspost"
        unless post = notice.kind
          notice.destroy
        else
          gooder = notice.kind.gooders.includes(:notices).where.not(id: current_user.id)
          if gooder.blank?
            notice.destroy
          else
            @gposters << gooder
            @posts << post
          end
        end
      end
    end
  
    @notices.reload
  end

end
