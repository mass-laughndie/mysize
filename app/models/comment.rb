class Comment < ApplicationRecord
  extend Search

  search_fields :content

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

  def good_notice_create_or_update
    return create_notice(user_id: self.user_id) if self.notice.nil?
    notice.add_unread_count!
  end

  def good_notice_check_or_delete
    return if self.goods.any? || !(good_notice = self.notice)
    good_notice.destroy
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

  def gooders_without_ownself
    gooders.where.not(id: current_user.id)
  end
end
