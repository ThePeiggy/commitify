class SessionsController < ApplicationController
  skip_before_filter :verify_logged_in

  def create
    facebook = User.koala(request.env['omniauth.auth']['credentials'])
    facebook_user = facebook.get_object("me")
    @user = User.find_or_create_by(email: facebook_user["email"]).tap do |user|
      user.update_attributes(first_name: facebook_user["first_name"], last_name: facebook_user["last_name"])
    end
    session[:user_id] = @user.id
    redirect_to user_path(@user.id)
  end
end
