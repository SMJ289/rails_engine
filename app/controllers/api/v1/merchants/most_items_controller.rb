class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.most_items_sold(merchant_params['quantity']))
  end

  def merchant_params
    params.permit(:quantity)
  end
end