class HomeController < ApplicationController
  skip_before_filter :verify_logged_in

  def index
  end

  def denied
  end

  def landing

  end
end
