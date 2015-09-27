class ApplicationController < ActionController::Base
  after_filter :register, only: [:update]
  protect_from_forgery

  def register
    @user = User.find(id=current_user.id)
    if @user.save and @user.registered and not @user.email_sent
      # User has just registered and updated, but email was not sent.
      @user.email_sent = true
      UserNotifier.important_information(@user).deliver
      @user.save
    end
  end

  private
  def render_permission_error
  	render file: 'public/permission_error', status: :error, layout: false
  end
end
