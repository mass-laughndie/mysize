class Notice < ApplicationRecord

  belongs_to :user
  belongs_to :kind, polymorphic: true,
                    optional:    true

  default_scope -> { order(updated_at: :desc) }

  validates :user_id,   presence: true
  validates :kind_id,   presence: true
  validates :kind_type, presence: true

  def add_unread_count!
    increment!(:unread_count, by = 1).touch
  end

  def get_post
    post = nil
    case self.kind_type
    when "ReplyCom", "NormalCom"
      return Comment.find_by(id: self.kind_id)
    when "ReplyPost"
      return Kickspost.find_by(id: self.kind_id)
    when "Comment", "Kickspost"
      return self.kind
    else
      return nil
    end
  end
end
