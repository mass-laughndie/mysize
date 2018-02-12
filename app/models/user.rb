class User < ApplicationRecord

  attr_accessor :validate_password, :remember_token
  has_many :kicksposts, dependent: :destroy

  before_save :downcase_email_and_mysizeid

  mount_uploader :image, ImageUploader

  validates :name, presence: { message: "名前を入力してください" },
                               length: { maximum: 50,
                                         message: "名前は50文字以内まで有効です" }

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
                                    on: :update }

  validate :image_size
  
  class << self

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(rem_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(rem_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def to_param
    mysize_id
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
end
