class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :kickspost

  default_scope -> { order(:created_at) }
  validates :user_id,         presence: { message: "user_idを入力してください"}
  validates :comment_content, presence: { message: "内容を入力してください" },
                              length:   { maximum: 500,
                                          message: "内容は500文字まで入力できます" }

  class << self

    def search(search)
      if search
        keyword_arys = search.gsub(/　/, " ").split()
        cond = where(["comment_content LIKE (?)", "%#{keyword_arys[0]}%"])
        for i in 1..(keyword_arys.length - 1) do
          cond = cond.where(["comment_content LIKE (?)", "%#{keyword_arys[i]}%"])
        end
        cond
      else
        all
      end
    end

  end
  
end
