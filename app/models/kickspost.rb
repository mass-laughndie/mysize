class Kickspost < ApplicationRecord

  belongs_to :user
  has_many   :comments, dependent: :destroy
  has_many   :goods,    as:        :post,
                        dependent: :destroy
  has_many   :gooders,  class_name: "User",
                        through:   :goods,
                        source:    :user
  has_one    :notice,   as:        :kind

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

  def gooded(user)
    goods.create(user_id: user.id)
  end

  def ungooded(user)
    goods.find_by(user_id: user.id).destroy
  end

  def gooded?(user)
    gooders.include?(user)
  end

  private

    def picture_size
      if picture.size > 10.megabytes
        error.add(:picture, "画像サイズは最大10MBまで設定できます")
      end
    end
end
