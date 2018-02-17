class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
         # :recoverable, :rememberable, :trackable, :validatable,
  #devise :omniauthable, omniauth_providers: [:twitter]

  attr_accessor :validate_name, :validate_password, :validate_shoesize,
                :remember_token, :reset_token
  has_many :kicksposts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy

  before_save :downcase_email_and_mysizeid

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

=begin
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
 
    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        email:    User.dummy_email(auth),
        password: Devise.friendly_token[0, 20],
        image: auth.info.image,
        name: auth.info.name,
        mysize_id: auth.info.nickname,
      )
    end
 
    user
  end
=end
  
  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    mysize_id = auth[:info][:nickname]
    email = User.dummy_email(auth)
    image = auth[:info][:image].sub("_normal", "")

    #find_or_create_by:条件を指定して初めの1件を取得し、1件もなければ作成
    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
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
    validate_name == 'true' || validate_name == true
  end

  def validate_shoesize?
    validate_shoesize == 'true' || validate_shoesize == true
  end

  def validate_password?
    validate_password == 'true' || validate_password == true
  end

  def current_user_upload
    current_user = @user
  end

  def feed
    Kickspost.where("user_id = ?", id)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

    def downcase_email_and_mysizeid
      email.downcase!
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
