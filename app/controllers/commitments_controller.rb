class CommitmentsController < ApplicationController
  respond_to :json, only: :sponsor

  def new
    @commitment = Commitment.new
  end

  def create
    @commitment = Commitment.new(commitment_params)
    @commitment.expiry_date = DateTime.now

    respond_to do |format|
      if @commitment.save
        options = { account: { name: "commitment_" + @commitment.id.to_s } }
        response = coinbase.post('/accounts', options)
        @commitment.update_attributes(account_id: response["account"]["id"])
        current_user.sponsorships.create(commitment_id: @commitment.id, sponsorship_type: Sponsorship::OWNERSHIP)
        format.html { redirect_to current_user, notice: 'Commitment was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @commitment.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @commitments = Commitment.all
    #binding.pry
  end

  def sponsor
    #create sponsorship
    #respond with number of sponsors
    commitment = Commitment.find(commitment_id_param)
    sponsorship = commitment.sponsorships.create(cost: 0.1, user_id: current_user.id, sponsorship_type: Sponsorship::SPONSORSHIP)
    respond_with success: true, sponsors: commitment.sponsor_count, cost_sponsored: commitment.cost_sponsored
  end

  private

  def commitment_id_param
    params.require(:id)
  end

  def commitment_params
    params.require(:commitment).permit(:title, :description, :cost)
  end
end
