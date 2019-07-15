class ForgotPasswordUser < User
  self.table_name = "users"

  attr_accessor :reset_token

  validates :password, presence:     { message: "Passwordを入力してください" },
                       length:       { minimum: 6,
                                       message: "Passwordは6文字以上で入力してください",
                                       allow_blank: true },
                       confirmation: { message: "PasswordとPassword確認が不一致です",
                                        allow_blank: true }
  validates :password_confirmation,  presence: { message: "Password確認を入力してください" }

  def create_reset_digest_and_e_token
    self.reset_token = new_reset_token
    update_columns(reset_digest: generate_digest(reset_token),
                   e_token: generate_digest(email),
                   reset_sent_at: Time.zone.now)
  end

  def reset_token_authenticated?(token)
    authenticated?(:reset, token)
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def password_reset_expired?
    return true if reset_sent_at.nil?
    reset_sent_at < 2.hours.ago
  end

  private

  def new_reset_token
    SecureRandom.uuid
  end

  def generate_digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end