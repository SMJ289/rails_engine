class Api::V1::MerchantByItemController < ApplicationController
  def show
    merchant = Item.find(params[:item_id]).merchant
    render json: MerchantSerializer.new(merchant)
  end
end