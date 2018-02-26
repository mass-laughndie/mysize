class Kickspost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
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

  private

    def picture_size
      if picture.size > 10.megabytes
        error.add(:picture, "画像サイズは最大10MBまで設定できます")
      end
    end
end
