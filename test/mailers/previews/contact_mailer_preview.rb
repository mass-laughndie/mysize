# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  # Preview this email at
  # http://localhost:3000/rails/mailers/contact_mailer/received_message
  def received_message
    contact = Contact.first
    ContactMailer.received_message(contact)
  end

end
