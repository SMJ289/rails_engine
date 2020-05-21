require 'rails_helper'

describe 'Merchant API' do
  it 'can find one merchant by name query parameter' do
    merchant1 = Merchant.create(name: 'Steve World')
    merchant2 = Merchant.create(name: 'Bob World')
    merchant3 = Merchant.create(name: 'Sue World')

    query = 'eve'
    
    get "/api/v1/merchants/find?name=#{query}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)
  
    expect(merchants.length).to eq(1)
    expect(merchants[:data][:attributes][:name]).to eq(merchant1.name)

  end

  it 'can find all merchants by name query parameter' do
    merchant1 = Merchant.create(name: 'Steve World')
    merchant2 = Merchant.create(name: 'Bob World')
    merchant3 = Merchant.create(name: 'Sue World')
    merchant4 = Merchant.create(name: 'Stan Land')

    query = 'orld'
    
    get "/api/v1/merchants/find_all?name=#{query}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(3)
  end
end