class SessionsController < ApplicationController
  skip_before_filter :verify_logged_in

  def create
    facebook = User.koala(request.env['omniauth.auth']['credentials'])
    facebook_user = facebook.get_object("me")
    @user = User.find_or_create_by(email: facebook_user["email"])
    session[:user_id] = @user.id
    redirect_to root_url
  end
end
