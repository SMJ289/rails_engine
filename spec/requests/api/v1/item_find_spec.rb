require 'rails_helper'

describe 'Item API' do
  it 'can find one item by name query parameter' do
    item1 = create(:item, name: 'Steve Item')
    item2 = create(:item, name: 'Bob Item')
    item3 = create(:item, name: 'Sue Item')

    query = 'eve'
    
    get "/api/v1/items/find?name=#{query}"

    expect(response).to be_successful

    item_response = JSON.parse(response.body, symbolize_names: true)
  
    expect(item_response.length).to eq(1)
    expect(item_response[:data][:attributes][:name]).to eq(item1.name)

  end

  it 'can find all items by name query parameter' do
    item1 = create(:item, name: 'Steve Item')
    item2 = create(:item, name: 'Bob Item')
    item3 = create(:item, name: 'Sue Item')

    query = 'item'
    
    get "/api/v1/items/find_all?name=#{query}"

    expect(response).to be_successful

    item_response = JSON.parse(response.body, symbolize_names: true)
  
    expect(item_response[:data].length).to eq(3)
  end

  it 'can find one item by description query parameter' do
    item1 = create(:item, description: 'The apple')
    item2 = create(:item, description: 'The banana')
    item3 = create(:item, description: 'The smelly orange')
    item4 = create(:item, description: 'Grape')

    query = 'apple'
    
    get "/api/v1/items/find?description=#{query}"

    expect(response).to be_successful

    item_response = JSON.parse(response.body, symbolize_names: true)
  
    expect(item_response.length).to eq(1)
    expect(item_response[:data][:attributes][:name]).to eq(item1.name)
  end

  it 'can find all items by description query parameter' do
    item1 = create(:item, description: 'The apple')
    item2 = create(:item, description: 'The banana')
    item3 = create(:item, description: 'The smelly orange')
    item4 = create(:item, description: 'Grape')

    query = 'the'
    
    get "/api/v1/items/find_all?description=#{query}"

    expect(response).to be_successful

    item_response = JSON.parse(response.body, symbolize_names: true)
  
    expect(item_response[:data].length).to eq(3)
  end

  it 'can find one item by unit_price query parameter' do
    item1 = create(:item, unit_price: '12.50')
    item2 = create(:item, unit_price: '10.50')
    item3 = create(:item, unit_price: '9.50')

    query = '12.50'
    
    get "/api/v1/items/find?unit_price=#{query}"

    expect(response).to be_successful

    item_response = JSON.parse(response.body, symbolize_names: true)
  
    expect(item_response.length).to eq(1)
    expect(item_response[:data][:attributes][:name]).to eq(item1.name)

  end

  it 'can find all items by unit_price query parameter' do
    item1 = create(:item, unit_price: '12.50')
    item2 = create(:item, unit_price: '12.50')
    item3 = create(:item, unit_price: '12.50')

    query = '12.50'
    
    get "/api/v1/items/find_all?unit_price=#{query}"

    expect(response).to be_successful

    item_response = JSON.parse(response.body, symbolize_names: true)
  
    expect(item_response[:data].length).to eq(3)
  end

  it 'can find one item by 2 queries when both parameters match' do
    item1 = create(:item, name: 'Boat', description: "Floats on water.", unit_price: 10.85)
    item2 = create(:item, name: 'Car', description: 'Has wheels.', unit_price: 7.55)
    item3 = create(:item, name: 'Plane', description: 'Flies in the air.', unit_price: 212.75)
    
    name_query = 'boat'
    description_query = 'water'

    get "/api/v1/items/find?name=#{name_query}&description=#{description_query}"
  
    expect(response).to be_successful

    item_response = JSON.parse(response.body, symbolize_names: true)
    expect(item_response.length).to eq(1)
    expect(item_response[:data][:attributes][:name]).to eq(item1.name)

    name_query = 'boat'
    description_query = 'wheels'

    get "/api/v1/items/find?name=#{name_query}&description=#{description_query}"
  
    expect(response).to be_successful
    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(item_response[:data]).to be_nil

    price_query = 10.85
    description_query = 'water'

    get "/api/v1/items/find?price=#{price_query}&description=#{description_query}"
  
    expect(response).to be_successful

    item_response = JSON.parse(response.body, symbolize_names: true)
    expect(item_response.length).to eq(1)
    expect(item_response[:data][:attributes][:name]).to eq(item1.name)

    name_query = 'car'
    price_query = 7.55

    get "/api/v1/items/find?name=#{name_query}&price=#{price_query}"
  
    expect(response).to be_successful
    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(item_response.length).to eq(1)
    expect(item_response[:data][:attributes][:name]).to eq(item2.name)
  end

  it 'can find one item by 3 queries when all parameters match' do
    item1 = create(:item, name: 'Boat', description: "Floats on water.", unit_price: 10.85)
    item2 = create(:item, name: 'Car', description: 'Has wheels.', unit_price: 7.55)
    item3 = create(:item, name: 'Plane', description: 'Flies in the air.', unit_price: 212.75)
    
    name_query = 'boat'
    description_query = 'water'
    price_query = 10.85

    get "/api/v1/items/find?name=#{name_query}&description=#{description_query}&unit_price=#{price_query}"
  
    expect(response).to be_successful

    item_response = JSON.parse(response.body, symbolize_names: true)
    expect(item_response.length).to eq(1)
    expect(item_response[:data][:attributes][:name]).to eq(item1.name)
    
    name_query = 'boat'
    description_query = 'flies'
    price_query = 10.85

    get "/api/v1/items/find?name=#{name_query}&description=#{description_query}&unit_price=#{price_query}"
  
    expect(response).to be_successful

    item_response = JSON.parse(response.body, symbolize_names: true)
    
    expect(item_response[:data]).to be_nil
  end

  it 'can find all items by 2 queries when both parameters match' do
    item1 = create(:item, name: 'Small Boat', description: "Floats on water.", unit_price: 10.85)
    item2 = create(:item, name: 'Tiny Car', description: 'Has wheels.', unit_price: 7.55)
    item3 = create(:item, name: 'Micro Plane', description: 'Flies in the air.', unit_price: 212.75)
    
    item4 = create(:item, name: 'Big Boat', description: "Floats on seawater.", unit_price: 10.85)
    item5 = create(:item, name: 'Large Car', description: 'Has rubber wheels.', unit_price: 7.55)
    item6 = create(:item, name: 'Giant Plane', description: 'Flies in the warm air.', unit_price: 212.75)
    
    name_query = 'boat'
    description_query = 'water'

    get "/api/v1/items/find_all?name=#{name_query}&description=#{description_query}"
  
    expect(response).to be_successful

    item_response = JSON.parse(response.body, symbolize_names: true)
    expect(item_response[:data].length).to eq(2)

    name_query = 'boat'
    description_query = 'wheels'

    get "/api/v1/items/find_all?name=#{name_query}&description=#{description_query}"
  
    expect(response).to be_successful
    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(item_response[:data]).to eq([])

    price_query = 10.85
    description_query = 'water'

    get "/api/v1/items/find_all?price=#{price_query}&description=#{description_query}"
  
    expect(response).to be_successful

    item_response = JSON.parse(response.body, symbolize_names: true)
    expect(item_response[:data].length).to eq(2)

    name_query = 'car'
    price_query = 7.55

    get "/api/v1/items/find_all?name=#{name_query}&price=#{price_query}"
  
    expect(response).to be_successful
    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(item_response[:data].length).to eq(2)
  end
end