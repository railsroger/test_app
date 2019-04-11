class ApplicationMailer < ActionMailer::Base
  default from: Spree::Store.first.mail_from_address
  layout 'mailer'
end
