class NoticesController < ApplicationController
  before_action :logged_in_user

  def show
    @notices   = current_user.notices.includes(:user)
    current_user.delete_past_notices_already_read(@notices)
    reset_unread_count_by(@notices)

    #TODO: Refactoring

    #期間ごとのフォロワーの２重配列作成
    @fcounts = []
    @followers = []
    @notices.where(kind_type: "Follow").each do |notice|
      relations = relationships_which_notice_created_on(notice.created_at)
      notice.destroy or next if relations.blank?

      @fcounts.unshift(relations.size)
      @followers.unshift(latest_two_followers_by(relations))
    end
    #フォロワー格納配列から週を指定するのに利用(全通知リストが最新順のため後ろの配列から表示)
    @fnum = @fcounts.size - 1 

    #TODO: Refactoring

    #その他の通知関連
    @posts = []
    @gcommers = []            #comments.gooders
    @gposters = []            #kicksposts.gooders
    @notices.each do |notice|
      post = notice.get_post
      notice.destroy or next if post.nil?

      ntype = notice.kind_type
      if ntype.in?(["ReplyCom", "NormalCom", "ReplyPost"])
        @posts << post
      elsif ntype.in?(["Comment", "Kickspost"])
        gooders = post.gooders_without(current_user)
        notice.destroy or next if gooders.blank?
        @posts << post
        @gcommers << gooders if ntype == "Comment"
        @gposters << gooders if ntype == "Kickspost"
      end
    end

    #各配列のindexnumber
    @pnum  = 0
    @gcnum = 0
    @gpnum = 0
  
    @notices.reload
  end

  private

  def reset_unread_count_by(notices)
    urnotices = notices.where.not(unread_count: 0)
    return if urnotices.none?
    urnotices.each do |notice|
      notice.decrement!(:unread_count, notice.unread_count)
    end
  end

  def relationships_which_notice_created_on(time)
    current_user.passive_relationships.where(created_at: that_week(time)).order(created_at: :desc)
  end

  def latest_two_followers_by(relations)
    User.find(relations.pluck(:follower_id).first(2))
  end
end
