class ContactMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.received_message.subject
  #
  def received_message(contact)
    @contact = contact

    #宛先は管理者
    mail to: 'mysize_sns@outlook.com', subject: "お問い合わせを受け取りました。(お問い合わせ番号 #{contact.id})"
  end
end
