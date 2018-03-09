class Notice < ApplicationRecord

  belongs_to :user
  belongs_to :kind,     polymorphic: true

  default_scope -> { order(created_at: :desc) }

  validates :user_id,   presence: true
  validates :kind_id,   presence: true
  validates :kind_type, presence: true

end
