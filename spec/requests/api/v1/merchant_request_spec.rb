require 'rails_helper'

describe 'Merchant API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    
    expect(merchants["data"].length).to eq(3)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["id"]).to eq(id)
  end

  it "can create a new merchant" do
    merchant_params = { name: "Waffle House" }

    post "/api/v1/merchants", params: merchant_params
    merchant = Merchant.last
    merchant_response = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
    expect(merchant_response['data']['attributes']['name']).to eq(merchant_params[:name])
  end

  it "can update an existing merchant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: "IHOP" }

    put "/api/v1/merchants/#{id}", params: merchant_params
    merchant = Merchant.find_by(id: id)
    merchant_response = JSON.parse(response.body)
    
    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq("IHOP")
    expect(merchant_response['data']['attributes']['name']).to eq("IHOP")
  end

  it "can destroy a merchant" do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can find all items associated with given merchant' do
    merchant1 = create(:merchant) 

    item1 = create(:item, merchant_id: merchant1.id)
    item2 = create(:item, merchant_id: merchant1.id)
    item3 = create(:item, merchant_id: merchant1.id)
    
    merchant = Merchant.find_by(id: merchant1.id)
    get "/api/v1/merchants/#{merchant1.id}/items"
    merchant_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_response[:data].length).to eq(3)
    expect(merchant_response[:data].first[:id]).to eq(item1.id.to_s)
  end
end