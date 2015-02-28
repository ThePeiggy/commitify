class UsersController < ApplicationController

  def index

  end

  def show
    if current_user.id != params[:id].to_i
      redirect_to denied_path
      return
    end

    @user = User.find(params[:id])
  end
end
