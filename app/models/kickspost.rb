class Kickspost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: { message: "内容を入力してください" },
                      length:   { maximum: 500,
                                  massage: "500文字まで入力できます" }
  validates :picture, presence: { message: "ファイルを選択してください"}
  validates :size,    presence: { message: "スニーカーのサイズを選択してください" }
end
