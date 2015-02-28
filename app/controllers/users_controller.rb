class UsersController < ApplicationController

  def index
    @user = User.find(session[:user_id])
  end

  def login
    /
    facebook = User.koala(request.env['omniauth.auth']['credentials'])
    facebook_user = facebook.get_object("me")
    @user = User.where(email: facebook_user["email"]).first_or_create
    session[:user_id] = @user.id
    /
    #@friends = facebook.get_connections(@user["id"], "friends")
    #facebook.get_object("me?fields=name,picture")
  end
end
