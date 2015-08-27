class UserMailer < ActionMailer::Base
  default from: "from@hackru.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://hackRU.com/login'
    mail(to: @user.email, subject 'Welcome to hackRU!')
  end
end
