class User < ApplicationRecord

  attr_accessor :validate_name, :validate_password, :validate_shoesize,
                :remember_token, :reset_token

  has_many :kicksposts, dependent: :destroy
  has_many :comments,   dependent: :destroy
  has_many :notices,    dependent: :destroy
  has_many :goods,      dependent: :destroy

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  before_save :downcase_email
  before_save :downcase_mysizeid

  mount_uploader :image, ImageUploader

  validates :name, presence: { message: "名前を入力してください",
                               if: :validate_name? },
                   length: { maximum: 50,
                             message: "名前は50文字以内まで有効です",
                             allow_blank: true }

  VALID_MYSIZE_ID_REGIX = /\A[a-zA-Z0-9_]+\z/
  validates :mysize_id, presence:   { message: "MysizeIDを入力してください" },
                        length:     { maximum: 15,
                                      message: "MysizeIDは15文字以内まで有効です" },
                        format:     { with: VALID_MYSIZE_ID_REGIX,
                                      message: "MysizeIDは英数字,_(アンダーバー)のみ使用できます",
                                      allow_blank: true },
                        uniqueness: { case_sensitive: false,
                                      message: "そのMysizeIDは既に使われています" }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:   { message: "メールアドレスを入力してください" },
                    length:     { maximum: 255,
                                  message: "メールアドレスは255文字以内まで有効です" },
                    format:     { with: VALID_EMAIL_REGEX,
                                  message: "メールアドレスは不正な値です",
                                  allow_blank: true },
                    uniqueness: { case_sensitive: false,
                                  message: "そのメールアドレスは既に登録されています" }

  has_secure_password validations: false

  with_options if: :validate_password? do
    validates :password, presence:     { message: "Passwordを入力してください" },
                         length:       { minimum: 6,
                                         message: "Passwordは6文字以上で入力してください",
                                         allow_blank: true },
                         confirmation: { message: "PasswordとPassword確認が不一致です",
                                         allow_blank: true }
    validates :password_confirmation,  presence: { message: "Password確認を入力してください" }
  end

  validates :profile_content, length: { maximum: 160,
                                        massage: "プロフィールは160字以内で入力してください" }

  validates :shoe_size, presence: { message: "スニーカーのサイズを選択してください",
                                    if: :validate_shoesize? }

  validate :image_size

  # validates :uid, presence: true
  
  class << self

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def new_reset_token
      SecureRandom.uuid
    end

    def search(search)
      if search
        keyword_arys = search.gsub(/　/, " ").split()
        size_search = keyword_arys[0].to_f
        cond = where(["name LIKE (?) OR mysize_id LIKE (?) OR profile_content LIKE (?) OR shoe_size IN (?)",
               "%#{keyword_arys[0]}%", "%#{keyword_arys[0]}%", "%#{keyword_arys[0]}%", "#{size_search}"])
        for i in 1..(keyword_arys.length - 1) do
          size_search = keyword_arys[i].to_f
          cond = cond.where(["name LIKE (?) OR mysize_id LIKE (?) OR profile_content LIKE (?) OR shoe_size IN (?)",
               "%#{keyword_arys[i]}%", "%#{keyword_arys[i]}%", "%#{keyword_arys[i]}%", "#{size_search}"])
        end
        cond
      else
        all
      end
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #tokenがdigestと一致 => true
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def send_welcome_email
    mail = UserMailer.welcome(self)
    mail.transport_encoding = "8bit"
    mail.deliver_now
  end

  def create_reset_digest_and_e_token
    self.reset_token = User.new_reset_token
    update_columns(reset_digest: User.digest(reset_token),
                   e_token: User.digest(email),
                   reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    mail = UserMailer.password_reset(self)
    mail.transport_encoding = "8bit"
    mail.deliver_now
  end

  def self.find_or_create_from_auth(auth)
    provider  = auth[:provider]
    uid       = auth[:uid]
    name      = auth[:info][:name]
    mysize_id = auth[:info][:nickname]
    email     = User.dummy_email(auth)
    image     = auth[:info][:image].sub("_normal", "")

    #find_or_create_by:条件を指定して初めの1件を取得し、1件もなければ作成
    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name  = name
      user.email = email
      user.remote_image_url = image
      if User.find_by(mysize_id: mysize_id).nil?
        user.mysize_id = mysize_id
      end
    end
  end

  def to_param
    mysize_id
  end

=begin
  def validate_on?(name)
    send("validate_#{param}") == 'true' || send("validate_#{param}") == true
  end
=end

  def validate_name?
    validate_name.in?(['true', true])
  end

  def validate_shoesize?
    validate_shoesize.in?(['true', true])
  end

  def validate_password?
    validate_password.in?(['true', true])
  end

  def current_user_upload
    current_user = @user
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    Kickspost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def follow(other)
    active_relationships.create(followed_id: other.id)
  end

  def unfollow(other)
    active_relationships.find_by(followed_id: other.id).destroy
  end

  def following?(other)
    following.include?(other)
  end

  def create_comment_notice(kind, model)
    notices.create(kind: kind, kind_id: model.id)
  end

  def delete_comment_notice(kind, model)
    notices.where(kind: kind, kind_id: model.id).each do |notice|
      notice.destroy
    end
  end

  #list系の更新or作成
  def create_follow_notice(kind_list, model)
    this_day = Time.zone.now.all_day
    # this_week = Time.zone.now.beginning_of_week..Time.zone.now.end_of_week
    notice = self.notices.find_by(kind: kind_list, created_at: this_day)
    #今週のlistがある場合
    if notice
      #listのupdated_atを更新 => noticeビューの上段に持ってくる
      notice.increment!(:unread_count, by = 1)
    #ない場合
    else
      #list作成(kind_idはlistの最初のnotice内のkind_idと同じ
      #         => 期間内削除時[=最初のnotice削除時]に使用)
      notices.create(kind: kind_list, kind_id: model.id)
    end
  end

  #期間period内のlist系通知の要素が空の場合に削除
  def delete_follow_notice(kind_list, period)
    #期間内のフォローされた履歴
    relations = self.passive_relationships.where(created_at: period)
    #期間中に特定のnoticeが１つもない場合
    if relations.blank?
      #その期間のlistがあれば削除(基本あるはず)
      if notice_list = notices.find_by(kind: kind_list, created_at: period)
        notice_list.destroy
      end
    end
  end

  def good(kind, model)
    goods.create(kind: kind, kind_id: model.id)
  end

  def ungood(kind, model)
    goods.find_by(kind: kind, kind_id: model.id).destroy
  end

  def good?(kind, model)
    goods.where(kind: kind).pluck(:kind_id).include?(model.id)
  end

  def create_good_notice(kind_list, model)
    notice = self.notices.find_by(kind: kind_list, kind_id: model.id)
    #そのポストのlistがある場合
    if notice
      #listのupdated_atを更新 => noticeビューの上段に持ってくる
      notice.increment!(:unread_count, by = 1)
    #ない場合
    else
      #list作成(kind_idはmodelのidと同じ
      notices.create(kind: kind_list, kind_id: model.id)
    end
  end

  #postのlist系通知の要素が空の場合に削除
  def delete_good_notice(kind, model)
    goods = Good.where(kind: kind, kind_id: model.id)
    #期間中に特定のnoticeが１つもない場合
    if goods.blank?
      #そのnoticeのlistがあれば削除
      if notice_list = notices.find_by(kind: kind + "_list", kind_id: model.id)
        notice_list.destroy
      end
    end
  end

  #既読済みの期間以前の通知を削除
  #notices = current_userの全通知
  def delete_past_notices_already_read(notices)
    #削除ライン([テスト]1.day.ago => [本番]10.week.ago)
    deleteline = Time.new(2000,1,1)..25.week.ago
    #削除ライン以前に更新された未読0の通知
    exnotices = notices.where(unread_count: 0, updated_at: deleteline)
    exnotices.destroy_all
=begin
    #既読数 = 要素通知数 - 未読通知数
    readnum = enotices.count - self.notice_count

    #削除ライン以前の要素通知
    cnotices = enotices.where(created_at: deleteline)
    #存在する && 既読がある場合
    if cnotices.any? && readnum > 0
      #cnoticesの既読済みを抽出して削除
      cnotices.last(readnum).each do |notice|
        notice.destroy
      end

      #空になったlistも削除
      #削除ライン以前のlist系抽出
      list_notices = notices
                      .where('kind LIKE ?', '%_list%')
                      .where(created_at: deleteline)
      #存在する場合
      if list_notices.any?
        #各list系通知の期間内の要素が空なら削除
        list_notices.each do |list|
          #listの要素kind名抽出
          lkind = list.kind.sub(/_list/, '')
          if lkind == "follow"
            list_week = list.created_at.beginning_of_week..list.created_at.end_of_week
            self.week_follow_notice_delete(lkind, list_week)
          else
            if lkind == "gpost"
              post = Kickspost.find_by(id: list.kind_id)
            elsif lkind == "gcom"
              post = Comment.find_by(id: list.kind_id)
            end
            self.post_notice_list_delete(lkind, post)
          end
        end
      end
    end
=end
  end

  private

    def downcase_email
      email.downcase!
    end

    def downcase_mysizeid
      mysize_id.downcase!
    end

    def image_size
      if image.size > 10.megabytes
        error.add(:image, "画像サイズは最大10MBまで設定できます")
      end
    end

    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end

end
