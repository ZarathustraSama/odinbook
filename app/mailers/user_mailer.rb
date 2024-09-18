class UserMailer < ApplicationMailer
  default from: 'mr.gabriel@live.it'

  def welcome_email
    @user = params[:user]
    @url  = 'https://odinbook-production-4253.up.railway.app/'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
