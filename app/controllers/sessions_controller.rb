class SessionsController < ApplicationController
  skip_before_filter :verify_logged_in

  def create
    facebook = User.koala(request.env['omniauth.auth']['credentials'])
    facebook_user = facebook.get_object("me")
    @user = User.where(email: facebook_user["email"]).first_or_create
    session[:user_id] = @user.id
    redirect_to root_url
  end
end
