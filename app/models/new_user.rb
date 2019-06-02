class NewUser < User
  self.table_name = "users"

  before_save :downcase_email
  before_save :downcase_mysizeid

  validates :password, presence:     { message: "Passwordを入力してください" },
                       length:       { minimum: 6,
                                       message: "Passwordは6文字以上で入力してください",
                                       allow_blank: true },
                       confirmation: { message: "PasswordとPassword確認が不一致です",
                                        allow_blank: true }
  validates :password_confirmation,  presence: { message: "Password確認を入力してください" }

  DEFAULT_SHOESIZE = 27.0

  private

  def downcase_email
    email.downcase!
  end

  def downcase_mysizeid
    mysize_id.downcase!
  end
end