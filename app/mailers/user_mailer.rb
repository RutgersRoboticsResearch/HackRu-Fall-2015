class UserMailer < ActionMailer::Base
	default :from => "team@hackru.com"
	
	def registration_confirmation(user)
		@user = user
		mail(to: @user.email, :subject => 'Welcome to hackRU!')
	end

  def important_information(user)
    @user = user
    mail(to: @user.email, :subject => 'Welcome to hackRU!')
  end

end
