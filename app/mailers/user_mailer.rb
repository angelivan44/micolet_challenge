class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'
  def welcome_email(destino)
    mail(to: destino , cc: "angelhuayas@gmail.com", subject: 'Welcome to My Awesome Site')
  end
end
