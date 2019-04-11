class PostbotMailer < ApplicationMailer
  def message_to_manager(id)
    @message = Spree::Message.find(id)
    mail to: Spree::Store.first.mail_from_address,
         subject: @message.subject
  end
end
