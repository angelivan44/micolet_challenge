class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  def welcome_email(destino)
    mail(to: destino, subject: 'Welcome to My Awesome Site')
  end
end
