class Notice < ApplicationRecord

  belongs_to :user
  belongs_to :kind, polymorphic: true,
                    optional:    true

  default_scope -> { order(updated_at: :desc) }

  validates :user_id,   presence: true
  validates :kind_id,   presence: true
  validates :kind_type, presence: true

end
