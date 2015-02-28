class CommitmentsController < ApplicationController
  def new
    @commitment = Commitment.new
  end

  def create
    @commitment = Commitment.new(commitment_params)
    @commitment.expiry_date = DateTime.now

    respond_to do |format|
      if @commitment.save
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


  end

  private

  def commitment_params
    params.require(:commitment).permit(:title, :description, :cost)
  end
end
