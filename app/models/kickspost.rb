class Kickspost < ApplicationRecord
  extend Search
  
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
    def search(keywords)
      fields = [:title, :color, :brand, :content]
      self.search_condition(keywords, fields, :size)
    end
  end
  
  def good_notice_create_or_update
    if self.notice.nil?
      create_notice(user_id: self.user_id)
    else
      notice.add_unread_count!
    end
  end

  def good_notice_check_or_delete
    if self.goods.blank? && good_notice = self.notice
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
