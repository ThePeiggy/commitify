class FulfillmentsController < ApplicationController
  def edit
    @fulfillment = Fulfillment.find(params[:id])
  end

  def update
    @fulfillment = Fulfillment.find(params[:id])

    if @fulfillment.update(fulfillment_params)
      @fulfillment.commitment.update_attributes(status: Commitment::FULFILLED)
      redirect_to current_user
    else
      render 'edit'
    end
  end

  private
    def fulfillment_params
      params.require(:fulfillment).permit(:description)
    end
end
