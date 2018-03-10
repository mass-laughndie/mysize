class Kickspost < ApplicationRecord

  belongs_to :user
  has_many   :comments, dependent: :destroy
  has_many   :goods,    as:        :post,
                        dependent: :destroy
  has_many   :gooders,  class_name: "User",
                        through:   :goods,
                        source:    :user
  has_one    :notice,   as:        :kind,
                        dependent: :destroy,
                        class_name: 'Notice'

  default_scope -> { order(created_at: :desc) }

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: { message: "ユーザーを特定できません"}
  validates :content, presence: { message: "内容を入力してください" },
                      length:   { maximum: 500,
                                  massage: "500文字まで入力できます" }
  validates :picture, presence: { message: "ファイルを選択してください",
                                  on: :create }
  validate  :picture_size
  validates :size,    presence: { message: "スニーカーのサイズを選択してください" }

  class << self

    def search(search)
      if search
        keyword_arys = search.gsub(/　/, " ").split()
        size_search = keyword_arys[0].to_f
        cond = where(["content LIKE (?) OR size IN (?)", "%#{keyword_arys[0]}%", "#{size_search}"])
        for i in 1..(keyword_arys.length - 1) do
          size_search = keyword_arys[i].to_f
          cond = cond.where(["content LIKE (?) OR size IN (?)", "%#{keyword_arys[i]}%", "#{size_search}"])
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
  
  def good_notice_create_or_update
    if self.notice.nil?
      create_notice(user_id: self.user.id)
    else
      notice.increment!(:unread_count, by = 1)
    end
  end

  def good_notice_check_or_delete
    if self.goods.blank? && !self.notice.nil? && good_notice = self.notice.find_by(user_id: self.user.id)
      good_notice.destroy
    end
  end

  #返信通知の作成(cuser = current_user)
  def check_and_create_notice_to_others_and(cuser)
    ids = self.content.scan(/@[a-zA-Z0-9_]+\s/)   #コメントに含まれる「@<mysize_id> 」の配列
    #配列が空でない場合(=返信である場合)
    if ids.any?
      ids.each do |msid|
        msid.delete!("@").delete!(" ")            #「@<mysize_id> 」 => 「<mysize_id>」
        other = User.find_by(mysize_id: msid)
        if other && other != cuser
          other.receive_notice_of("ReplyPost", self)     #cuser以外へのreply通知作成
        end
      end
    end
  end

  #返信通知の削除(cuser = current_user)
  def check_and_delete_notice_form_others_and(cuser)
    ids = self.content.scan(/@[a-zA-Z0-9_]+\s/)
    if ids.any?
      ids.each do |msid|
        msid.delete!("@").delete!(" ")
        other = User.find_by(mysize_id: msid)
        if other && other != cuser
          other.lose_notice_of("ReplyPost", self)     #cuser以外へのreply通知削除
        end
      end
    end
  end

  private

    def picture_size
      if picture.size > 10.megabytes
        error.add(:picture, "画像サイズは最大10MBまで設定できます")
      end
    end
end
