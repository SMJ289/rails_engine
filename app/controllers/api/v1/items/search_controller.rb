class Api::V1::Items::SearchController < ApplicationController

  def show
    render json: ItemSerializer.new(Item.find_by_params(item_params))
  end
  
  def index
    render json: ItemSerializer.new(Item.find_all_by_params(item_params))
  end
  
  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
