require 'rails_helper'

describe 'Item API' do
  it 'can find one item by name query parameter' do
    item1 = create(:item, name: 'Steve Item')
    item2 = create(:item, name: 'Bob Item')
    item3 = create(:item, name: 'Sue Item')

    query = 'eve'
    
    get "/api/v1/items/find?name=#{query}"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
  
    expect(items.length).to eq(1)
    expect(items[:data][:attributes][:name]).to eq(item1.name)

  end

  it 'can find all items by name query parameter' do
    item1 = create(:item, name: 'Steve Item')
    item2 = create(:item, name: 'Bob Item')
    item3 = create(:item, name: 'Sue Item')

    query = 'item'
    
    get "/api/v1/items/find_all?name=#{query}"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
  
    expect(items[:data].length).to eq(3)
  end

  it 'can find one item by description query parameter' do
    item1 = create(:item, description: 'The apple')
    item2 = create(:item, description: 'The banana')
    item3 = create(:item, description: 'The smelly orange')
    item4 = create(:item, description: 'Grape')

    query = 'apple'
    
    get "/api/v1/items/find?description=#{query}"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
  
    expect(items.length).to eq(1)
    expect(items[:data][:attributes][:name]).to eq(item1.name)
  end

  it 'can find all items by description query parameter' do
    item1 = create(:item, description: 'The apple')
    item2 = create(:item, description: 'The banana')
    item3 = create(:item, description: 'The smelly orange')
    item4 = create(:item, description: 'Grape')

    query = 'the'
    
    get "/api/v1/items/find_all?description=#{query}"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
  
    expect(items[:data].length).to eq(3)
  end

  it 'can find one item by unit_price query parameter' do
    item1 = create(:item, unit_price: '12.50')
    item2 = create(:item, unit_price: '10.50')
    item3 = create(:item, unit_price: '9.50')

    query = '12.50'
    
    get "/api/v1/items/find?unit_price=#{query}"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
  
    expect(items.length).to eq(1)
    expect(items[:data][:attributes][:name]).to eq(item1.name)

  end

  it 'can find all items by unit_price query parameter' do
    item1 = create(:item, unit_price: '12.50')
    item2 = create(:item, unit_price: '12.50')
    item3 = create(:item, unit_price: '12.50')

    query = '12.50'
    
    get "/api/v1/items/find_all?unit_price=#{query}"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
  
    expect(items[:data].length).to eq(3)
  end
end