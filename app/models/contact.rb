class Contact < ApplicationRecord
  validates :name,    presence: { message: "件名を入力してください。" },
                      length:   { maximum: 255,
                                  message: "件名は255文字以内まで有効です" }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,   presence: { message: "メールアドレスを入力してください" },
                      length:   { maximum: 255,
                                  message: "メールアドレスは255文字以内まで有効です" },
                      format:   { with:    VALID_EMAIL_REGEX,
                                  message: "そのメールアドレスは不正な値を含んでいます",
                                  allow_blank: true }

  validates :message, presence: { message: "お問い合わせ内容を入力してください。" },
                      length:   { maximum: 2000,
                                  message: "お問い合わせ内容は2000文字以内まで有効です" }

  def send_email(subject)
    mail = ContactMailer.send("#{subject}", self)
    mail.transport_encoding = "8bit"
    mail.deliver_now
  end
end
