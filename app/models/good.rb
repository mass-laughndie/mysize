class Good < ApplicationRecord

  belongs_to :user
  belongs_to :post, polymorphic: true, optional: true
  belongs_to :comment,   class_name: 'Comment',
                         foreign_key: 'post_id',
                         optional: true
  belongs_to :kickspost, class_name: 'Kickspost',
                         foreign_key: 'post_id',
                         optional: true

  default_scope -> { order(created_at: :desc) }

  validates :user_id,   presence: { message: "ユーザーを特定できません"}
  validates :post_id,   presence: { message: "投稿を特定できません"}
  validates :post_type, presence: { message: "投稿タイプを特定できません"}
  
end
