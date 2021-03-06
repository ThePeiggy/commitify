class CommitmentsController < ApplicationController
  respond_to :json, only: :sponsor

  def new
    @commitment = Commitment.new
  end

  def create
    @commitment = Commitment.new(commitment_params)

    respond_to do |format|
      if @commitment.save
        options = { account: { name: "commitment_" + @commitment.id.to_s } }
        response = coinbase.post('/accounts', options)
        @commitment.update_attributes(account_id: response["account"]["id"], status: Commitment::PENDING, beneficiary_id: @commitment.beneficiary == Commitment::USERS ? nil : "529653a1ce21cd9e53000076")

        current_user.sponsorships.create(commitment_id: @commitment.id, sponsorship_type: Sponsorship::OWNERSHIP)
        #take collateral
        coinbase.send_money @commitment.account_id, @commitment.cost, "This is your collateral.", account_id: @commitment.users.owner.account_id

        format.html { redirect_to current_user, notice: 'Commitment was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @commitment.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @commitments = Commitment.all
    @exchange_rate_usd = coinbase.exchange_rates["btc_to_usd"].to_f
    @commitments = @commitments.where(status: params[:filter]) if params[:filter]
  end

  def sponsor
    #create sponsorship
    #respond with number of sponsors
    commitment = Commitment.find(commitment_id_param)
    sponsorship = commitment.sponsorships.create(cost: 0.001, user_id: current_user.id, sponsorship_type: Sponsorship::SPONSORSHIP)
    if sponsorship.id.nil?
      respond_with success: false
      return
    end

    #set up transfer
    coinbase.send_money commitment.account_id, 0.001, "This is your sponsorship.", account_id: current_user.account_id

    respond_with success: true, sponsors: commitment.sponsor_count, cost_sponsored: commitment.cost_sponsored
  end

  def fulfill
    @commitment = Commitment.find(commitment_id_param)
    @fulfillment = Fulfillment.find_by_commitment_id(commitment_id_param)
    @fulfillment = @commitment.build_fulfillment(title: @commitment.title).save if @fulfillment.nil?

    redirect_to edit_fulfillment_path(@fulfillment)
  end


  private

  def commitment_id_param
    params.require(:id)
  end

  def commitment_params
    params.require(:commitment).permit(:title, :description, :cost, :beneficiary)
  end
end
