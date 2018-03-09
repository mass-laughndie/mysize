class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :kickspost
  has_many   :goods,    as:        :post,
                        dependent: :destroy
  has_many   :gooders,  class_name: "User",
                        through:   :goods,
                        source:    :user
  has_one    :notice,   as:        :kind

  default_scope -> { order(:created_at) }

  validates :user_id,      presence: { message: "ユーザーを特定できません"}
  validates :kickspost_id, presence: { message: "投稿を特定できません"}
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

  def gooded(user)
    goods.create(user_id: user.id)
  end

  def ungooded(user)
    goods.find_by(user_id: user.id).destroy
  end

  def gooded?(user)
    gooders.include?(user)
  end
  
end
