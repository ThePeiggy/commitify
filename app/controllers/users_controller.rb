class UsersController < ApplicationController

  def index

  end

  def show
    if current_user.id != params[:id].to_i
      redirect_to denied_path
      return
    end

    @exchange_rate_usd = coinbase.exchange_rates["btc_to_usd"].to_f
    @user = User.find(params[:id])
    @balance = coinbase.get('/accounts/' + @user.account_id)["account"]["balance"]["amount"].to_f
  end
end
