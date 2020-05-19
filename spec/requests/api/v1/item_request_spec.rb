require 'rails_helper'

describe 'Item API' do
  it 'sends a list of items' do
    merchant = create(:merchant)

    3.times do
      create(:item, merchant_id: merchant.id)
    end

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)
    
    expect(items["data"].count).to eq(3)
  end

  it "can get one item by its id" do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item["data"]["attributes"]["id"]).to eq(id)
  end

  it "can create a new item" do
    merchant = create(:merchant)
    item_params = { name: "Pencil", description: "No. 2", unit_price: 1.25, merchant_id: merchant.id }

    post "/api/v1/items", params: item_params
    item = Item.last
    item_response = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
    expect(item_response['data']['attributes']['name']).to eq(item_params[:name])
    expect(item_response['data']['attributes']['description']).to eq(item_params[:description])
    expect(item_response['data']['attributes']['unit_price']).to eq(item_params[:unit_price])
  end

  it 'can update an existing item' do
    merchant = create(:merchant)
    id = create(:item, merchant_id: merchant.id).id
    previous_attributes = Item.last
    item_params = { name: "Pencil", description: "No. 2", unit_price: 1.25, merchant_id: merchant.id }
    
    put "/api/v1/items/#{id}", params: item_params
    item = Item.find_by(id: id)
    item_response = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_attributes.name)
    expect(item.description).to_not eq(previous_attributes.description)
    expect(item.unit_price).to_not eq(previous_attributes.unit_price)
  end

  it "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can find the merchant by item' do
    item = create(:item)
    
    get "/api/v1/items/#{item.id}/merchant"
    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(item_response[:data][:attributes][:id]).to eq(item.merchant_id)
  end

end