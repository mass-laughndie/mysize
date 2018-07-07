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
        keyword_arys = search.split(/[\s　]+/)
        cond = where(["lower(content) LIKE (?)", "%#{keyword_arys[0]}%".downcase])
        for i in 1..(keyword_arys.length - 1) do
          cond = cond.where(["lower(content) LIKE (?)", "%#{keyword_arys[i]}%".downcase])
        end
        cond
      else
        all
      end
    end

  end
  
  #good通知の作成および更新
  def good_notice_create_or_update
    if self.notice.nil?
      create_notice(user_id: self.user.id)
    else
      notice.add_unread_count!
    end
  end

  #good通知のチェックおよび削除
  def good_notice_check_or_delete
    if self.goods.blank? &&  good_notice = self.notice
      good_notice.destroy
    end
  end

  def mysize_ids
    content.scan(/@[a-zA-Z0-9_]+/).map {|id| id.delete("@")}
  end

  def is_reply?
    mysize_ids.any?
  end

  def extract_others_replied_by(mysize_id, cuser)
    return nil if mysize_id == cuser.mysize_id
    User.find_by(mysize_id: mysize_id)
  end

  def create_notice_to_others_and(user, cuser)
    mysize_ids.each do |msid|
      other = self.extract_others_replied_by(msid, cuser)
      next if other.nil?
      other.receive_notice_of("ReplyCom", self) if other != user
    end
  end

  def create_comment_notice_for(user, cuser)
    user.receive_notice_of("NormalCom", self) unless user == cuser
  end

  def delete_notice_from_others_and(user, cuser)
    mysize_ids.each do |msid|
      other = self.extract_others_replied_by(msid, cuser)
      next if other.nil?
      other.lose_notice_of("ReplyCom", self)
    end
  end

  def delete_comment_notice_from(user, cuser)
    user.lose_notice_of("NormalCom", self) unless user == cuser
  end

end
