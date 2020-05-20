class Api::V1::Items::SearchController < ApplicationController

  def show
    if params['name'].present?
      render json: ItemSerializer.new(Item.find_by_name(params["name"]))
    elsif params['description'].present?
      render json: ItemSerializer.new(Item.find_by_description(params["description"]))
    elsif params['unit_price'].present?
      render json: ItemSerializer.new(Item.find_by_price(params["unit_price"]))
    end
  end
  
  def index
    if params['name'].present?
      render json: ItemSerializer.new(Item.find_all_by_name(params["name"]))
    elsif params['description'].present?
      render json: ItemSerializer.new(Item.find_all_by_description(params["description"]))
    elsif params['unit_price'].present?
      render json: ItemSerializer.new(Item.find_all_by_price(params["unit_price"]))
    end
  end
end