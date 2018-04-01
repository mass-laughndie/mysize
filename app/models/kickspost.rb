class Kickspost < ApplicationRecord

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

    def search(search)
      if search
        keyword_arys = search.gsub(/　/, " ").split()
        size_search = keyword_arys[0].to_f
        cond = where(["title LIKE (?) OR color LIKE (?) OR brand LIKE (?) OR content LIKE (?) OR size IN (?)",
                      "%#{keyword_arys[0]}%", "%#{keyword_arys[0]}%", "%#{keyword_arys[0]}%", "%#{keyword_arys[0]}%", "#{size_search}"])
        for i in 1..(keyword_arys.length - 1) do
          size_search = keyword_arys[i].to_f
          cond = cond.where(["title LIKE (?) OR color LIKE (?) OR brand LIKE (?) OR content LIKE (?) OR size IN (?)",
                             "%#{keyword_arys[i]}%", "%#{keyword_arys[i]}%", "%#{keyword_arys[i]}%", "%#{keyword_arys[i]}%", "#{size_search}"])
        end
        cond
      else
        all
      end
    end

  end

=begin
  def gooded(user)
    goods.create(user_id: user.id)
  end

  def ungooded(user)
    goods.find_by(user_id: user.id).destroy
  end

  def gooded?(user)
    gooders.include?(user)
  end
=end
  
  #good通知の作成および更新
  def good_notice_create_or_update
    #ポストの通知が作られていない(=good1つ目の)場合
    if self.notice.nil?
      #通知作成
      create_notice(user_id: self.user.id)
    #既に通知がある場合
    else
      #未読数+1
      notice.increment!(:unread_count, by = 1)
      notice.touch
    end
  end

  #good通知のチェックおよび削除
  def good_notice_check_or_delete
    #ポストのgood数が0 && noticeが見つかった　場合
    if self.goods.blank? &&  good_notice = self.notice
        #通知削除
        good_notice.destroy
    end
  end

  #返信通知の作成(cuser = current_user)
  def check_and_create_notice_to_others_and(cuser)
    ids = self.content.scan(/@[a-zA-Z0-9_]+\s|\r\n|\r/)   #コメントに含まれる「@<mysize_id> 」の配列
    #配列が空でない場合(=返信である場合)
    if ids.any?
      ids.each do |msid|
        msid = msid.delete("@").delete(" ").delete("\r\n").delete("\n") #「@<mysize_id> 」 => 「<mysize_id>」
        other = User.find_by(mysize_id: msid)
        if other && other != cuser
          other.receive_notice_of("ReplyPost", self)     #cuser以外へのreply通知作成
        end
      end
    end
  end

  #返信通知の削除(cuser = current_user)
  def check_and_delete_notice_form_others_and(cuser)
    ids = self.content.scan(/@[a-zA-Z0-9_]+\s|\r\n|\r/)
    if ids.any?
      ids.each do |msid|
        msid = msid.delete("@").delete(" ").delete("\r\n").delete("\n") #「@<mysize_id> 」 => 「<mysize_id>」
        other = User.find_by(mysize_id: msid)
        if other && other != cuser
          other.lose_notice_of("ReplyPost", self)     #cuser以外へのreply通知削除
        end
      end
    end
  end

  private

    def picture_size
      if picture.size > 5.megabytes
        error.add(:picture, "画像サイズは最大5MBまで設定できます")
      end
    end
end
