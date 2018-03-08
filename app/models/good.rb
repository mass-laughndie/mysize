class Good < ApplicationRecord
  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :kind_id, presence: true
  validates :kind,    presence: true
end
