class UserMailer < ApplicationMailer
  default from: 'crabaliciousteam@gmail.com'

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000/sessions/new'
    mail(to: @user.email, subject: 'Welcome to Crabalicious Film Reviews')
  end
end
