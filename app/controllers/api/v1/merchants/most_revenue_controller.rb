class Api::V1::Merchants::MostRevenueController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.find_most_revenue(merchant_params['quantity']))
  end

  private

  def merchant_params
    params.permit(:quantity)
  end
end