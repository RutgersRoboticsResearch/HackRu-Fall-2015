class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def mlh
    @user = User.from_omniauth(request.env["omniauth.auth"])

     if @user.persisted?
       @user.confirm! if request.env["omniauth.auth"]["info"]["email"] == @user.email
       sign_in_and_redirect @user, :event => :authentication
       set_flash_message(:notice, :success, :kind => "MLH") if is_navigational_format?
     else
       session["devise.mlh_data"] = request.env["omniauth.auth"]
       redirect_to new_user_registration_url
     end
  end
end
