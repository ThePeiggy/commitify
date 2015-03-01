require 'pry'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :verify_logged_in

  def verify_logged_in
    return if session[:user_id]
    redirect_to auth_provider_path
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def coinbase
    @coinbase ||= Coinbase::Client.new(ENV['COINBASE_APP_KEY'], ENV['COINBASE_APP_SECRET'])
  end
end
