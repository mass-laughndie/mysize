class Kickspost < ApplicationRecord
  extend Search

  search_fields :title, :color, :brand, :content, size_field: :size
  
  belongs_to :user
  has_many   :comments, dependent:  :destroy
  has_many   :goods,    as:         :post,
                        dependent:  :destroy,
                        class_name: "Good"
  has_many   :gooders,  through:    :goods,
                        source:     :gooder
  has_one    :notice,   as:         :kind,
                        dependent:  :destroy,
                        class_name: "Notice"

  default_scope -> { order(created_at: :desc) }

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: { message: "ユーザーを特定できません" }
  validates :title,   presence: { message: "スニーカー名を入力してください" },
                      length:   { maximum: 50,
                                  message: "スニーカー名は最大50文字まで入力できます" }
  validates :color,   presence: { message: "カラーを選択して下さい" },
                      length:   { maximum: 30,
                                  message: "カラーは最大30文字まで入力できます" }
  validates :brand,   presence: { message: "ブランドを選択して下さい" },
                      length:   { maximum: 30,
                                  message: "ブランドは最大30文字まで入力できます" }
  validates :content, presence: { message: "内容を入力してください" },
                      length:   { maximum: 500,
                                  massage: "500文字まで入力できます" }
  validates :picture, presence: { message: "ファイルを選択してください",
                                  on: :create }
  validate  :picture_size
  validates :size,    presence: { message: "スニーカーのサイズを選択してください" }

  class << self
    def all_format_gon_params_for(cuser)
      self.all.map do |post|
        map_gon_hah(post, cuser)
      end
    end

    def find_format_gon_params(ids, cuser)
      self.find(ids).map do |post|
        map_gon_hah(post, cuser)
      end
    end

    def find_format_gon_params_by(id, cuser)
      map_gon_hah(self.find_by(id: id), cuser)
    end

    private

    def extract_params_for_gon
      [:id, :user_id, :brand, :color, :title, :content, :size, :created_at, :picture_url]
    end

    def map_gon_hah(post, cuser)
      return if post.blank?
      post_type = post.class.name.downcase
      if cuser.present?
        is_good = cuser.good?(post_type, post)
        post_good = cuser.active_goods.find_by(post_type: post_type, post_id: post.id)
      else
        is_good = false
        post_good = nil
      end

      Hash[
        extract_params_for_gon.map do |ep|
          [ep, post.send(ep)]
        end
      ].merge({
        postType: post_type,
        postUser: User.find_format_gon_params_by(post.user_id),
        goodNum: post.goods.size,
        commentNum: post.comments.size,
        isGood: is_good,
        isMyPost: cuser == post.user,
        goodId: post_good.present? ? post_good.id : post_good
      })
    end
  end

  def good_notice_create_or_update
    return create_notice(user_id: self.user_id) if self.notice.nil?
    notice.add_unread_count!
  end

  def good_notice_check_or_delete
    return if self.goods.any? || !(good_notice = self.notice)
    good_notice.destroy
  end

  def mysize_ids
    content.scan(/@[a-zA-Z0-9_]+/).map {|id| id.delete("@")}
  end

  def is_reply?
    mysize_ids.any?
  end

  def extract_others_replied_by(mysize_id, cuser)
    return nil if mysize_id == cuser.mysize_id
    User.find_by(mysize_id: mysize_id)
  end

  def create_notice_to_others_from(cuser)
    mysize_ids.each do |msid|
      other = self.extract_others_replied_by(msid, cuser)
      next if other.nil?
      other.receive_notice_of("ReplyPost", self) 
    end
  end

  def delete_notice_from_others_by(cuser)
    mysize_ids.each do |msid|
      other = self.extract_others_replied_by(msid, cuser)
      next if other.nil?
      other.lose_notice_of("ReplyPost", self)
    end
  end

  def gooders_without_ownself
    gooders.where.not(id: current_user.id)
  end

  private

  def picture_size
    error.add(:picture, "画像サイズは最大5MBまで設定できます") if picture.size > 5.megabytes
  end
end
