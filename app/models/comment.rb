class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :kickspost
  has_many   :replies,  class_name:  "Comment",
                        foreign_key: "reply_id"
  belongs_to :reply,    class_name:  "Comment",
                        optional:    true
  has_many   :goods,    as:          :post,
                        dependent:   :destroy,
                        class_name:  "Good"
  has_many   :gooders,  through:     :goods,
                        source:      :gooder
  has_one    :notice,   as:          :kind,
                        dependent:   :destroy,
                        class_name:  "Notice"

  default_scope -> { order(:created_at) }

  validates :user_id,      presence: { message: "ユーザーを特定できません" }
  validates :kickspost_id, presence: { message: "投稿先を特定できません" }
  validates :reply_id,     presence: { message: "投稿先を特定できません" }
  validates :content,      presence: { message: "内容を入力してください" },
                           length:   { maximum: 500,
                                       message: "内容は500文字まで入力できます" }

  class << self

    def search(search)
      if search
        keyword_arys = search.gsub(/　/, " ").split()
        cond = where(["content LIKE (?)", "%#{keyword_arys[0]}%"])
        for i in 1..(keyword_arys.length - 1) do
          cond = cond.where(["content LIKE (?)", "%#{keyword_arys[i]}%"])
        end
        cond
      else
        all
      end
    end

  end

=begin
  def gooded(user)
    goods.create(user_id: user.id)
  end

  def ungooded(user)
    goods.find_by(user_id: user.id).destroy
  end

  def gooded?(user)
    gooders.include?(user)
  end
=end
  
  #good通知の作成および更新
  def good_notice_create_or_update
    #ポストの通知が作られていない(=good1つ目の)場合
    if self.notice.nil?
      #通知作成
      create_notice(user_id: self.user.id)
    #既に通知がある場合
    else
      #未読数+1
      notice.increment!(:unread_count, by = 1)
      notice.touch
    end
  end

  #good通知のチェックおよび削除
  def good_notice_check_or_delete
    #ポストのgood数が0 && noticeが見つかった　場合
    if self.goods.blank? &&  good_notice = self.notice
        #通知削除
        good_notice.destroy
    end
  end

  #コメント.返信通知の作成(user = kickspost.user, cuser = current_user)
  def check_and_create_notice_to_others_and(user, cuser)
    reply_check = false                           #userへの通知をコメントor返信どちらにするか
    ids = self.content.scan(/@[a-zA-Z0-9_]+\s|\r\n|\r/)   #コメントに含まれる「@<mysize_id> 」の配列
    #配列が空でない場合(=返信である場合)
    if ids.any?
      ids.each do |msid|
        msid = msid.delete("@").delete(" ").delete("\r\n").delete("\n") #「@<mysize_id> 」 => 「<mysize_id>」
        other = User.find_by(mysize_id: msid)
        if other && other != user && other != cuser
          other.receive_notice_of("ReplyCom", self)     #user以外へのreply通知作成
        elsif other == user && other != cuser
          user.receive_notice_of("ReplyCom", self)      #userへのreply通知作成
          reply_check = true
        end
      end
    end

    #userへの返信じゃない || userがコメ主でない  場合
    unless reply_check || user == cuser
      user.receive_notice_of("NormalCom", self)         #userへのコメント通知作成
    end
  end

  #コメント.返信通知の削除(user = kickspost.user, cuser = current_user)
  def check_and_delete_notice_form_others_and(user, cuser)
    reply_check = false
    ids = self.content.scan(/@[a-zA-Z0-9_]+\s/)
    if ids.any?
      ids.each do |msid|
        msid.delete!("@").delete!(" ")
        other = User.find_by(mysize_id: msid)
        if other && other != user && other != cuser
          other.lose_notice_of("ReplyCom", self)     #user以外へのreply通知削除
        elsif other == user && other != cuser
          user.lose_notice_of("ReplyCom", self)      #userへのreply通知削除
          reply_check = true
        end
      end
    end

    unless reply_check || user == cuser
      user.lose_notice_of("NormalCom", self)      #userへのコメント通知削除
    end
  end

end
