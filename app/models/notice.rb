class Notice < ApplicationRecord

  belongs_to :user

  default_scope -> { order(created_at: :desc) }

  validates :kind,    presence: true
  validates :user_id, presence: true
  validates :kind_id, presence: true

end
