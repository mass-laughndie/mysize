class Kickspost < ApplicationRecord

  belongs_to :user
  has_many   :comments, dependent:  :destroy
  has_many   :goods,    as:         :post,
                        dependent:  :destroy,
                        class_name: "Good"
  has_many   :gooders,  through:    :goods,
                        source:     :gooder
  has_one    :notice,   as:         :kind,
                        dependent:  :destroy,
                        class_name: "Notice"

  default_scope -> { order(created_at: :desc) }

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: { message: "ユーザーを特定できません" }
  validates :title,   presence: { message: "スニーカー名を入力してください" },
                      length:   { maximum: 50,
                                  message: "スニーカー名は最大50文字まで入力できます" }
  validates :color,   presence: { message: "カラーを選択して下さい" },
                      length:   { maximum: 30,
                                  message: "カラーは最大30文字まで入力できます" }
  validates :brand,   presence: { message: "ブランドを選択して下さい" },
                      length:   { maximum: 30,
                                  message: "ブランドは最大30文字まで入力できます" }
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
        keyword_arys = search.split(/[\s　]+/)
        size_search = keyword_arys[0].to_f
        cond = where(["lower(title) LIKE (?) OR lower(color) LIKE (?) OR lower(brand) LIKE (?) OR lower(content) LIKE (?) OR size IN (?)",
               "%#{keyword_arys[0]}%".downcase, "%#{keyword_arys[0]}%".downcase, "%#{keyword_arys[0]}%".downcase, "%#{keyword_arys[0]}%".downcase, "#{size_search}"])
        for i in 1..(keyword_arys.length - 1) do
          size_search = keyword_arys[i].to_f
          cond = cond.where(["lower(title) LIKE (?) OR lower(color) LIKE (?) OR lower(brand) LIKE (?) OR lower(content) LIKE (?) OR size IN (?)",
                 "%#{keyword_arys[i]}%".downcase, "%#{keyword_arys[i]}%".downcase, "%#{keyword_arys[i]}%".downcase, "%#{keyword_arys[i]}%".downcase, "#{size_search}"])
        end
        cond
      else
        all
      end
    end

  end
  
  def good_notice_create_or_update
    if self.notice.nil?
      create_notice(user_id: self.user.id)
    else
      notice.add_unread_count!
    end
  end

  def good_notice_check_or_delete
    good_notice.destroy if self.goods.blank? && good_notice = self.notice
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

  def create_notice_to_others_from(cuser)
    mysize_ids.each do |msid|
      other = self.extract_others_replied_by(msid, cuser)
      next if other.nil?
      other.receive_notice_of("ReplyPost", self) 
    end
  end

  def delete_notice_from_others_by(cuser)
    mysize_ids.each do |msid|
      other = self.extract_others_replied_by(msid, cuser)
      next if other.nil?
      other.lose_notice_of("ReplyPost", self)
    end
  end

  private

    def picture_size
      error.add(:picture, "画像サイズは最大5MBまで設定できます") if picture.size > 5.megabytes
    end
end
