require 'rails_helper'

describe 'Business Intelligence' do

  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @merchant5 = create(:merchant)
    customer = Customer.create(first_name: "steve", last_name: "meyers")
    
    10.times do
      create(:item, unit_price: 10, merchant_id: @merchant1.id)
      Invoice.create(customer_id: customer.id, status: "shipped", merchant_id: @merchant1.id)
      InvoiceItem.create(unit_price: Item.last.unit_price, item_id: Item.last.id, quantity: 10, invoice_id: Invoice.last.id)
      Transaction.create(invoice_id: Invoice.last.id, credit_card_number: 4654405418249632, result: "success")
    end
    10.times do
      create(:item, unit_price: 10, merchant_id: @merchant2.id)
      Invoice.create(customer_id: customer.id, status: "shipped", merchant_id: @merchant2.id)
      InvoiceItem.create(unit_price: Item.last.unit_price, item_id: Item.last.id, quantity: 9, invoice_id: Invoice.last.id)
      Transaction.create(invoice_id: Invoice.last.id, credit_card_number: 4654405418249632, result: "success")
    end
    10.times do
      create(:item, unit_price: 10, merchant_id: @merchant3.id)
      Invoice.create(customer_id: customer.id, status: "shipped", merchant_id: @merchant3.id)
      InvoiceItem.create(unit_price: Item.last.unit_price, item_id: Item.last.id, quantity: 8, invoice_id: Invoice.last.id)
      Transaction.create(invoice_id: Invoice.last.id, credit_card_number: 4654405418249632, result: "success")
    end
    10.times do
      create(:item, unit_price: 10, merchant_id: @merchant4.id)
      Invoice.create(customer_id: customer.id, status: "shipped", merchant_id: @merchant4.id)
      InvoiceItem.create(unit_price: Item.last.unit_price, item_id: Item.last.id, quantity: 7, invoice_id: Invoice.last.id)
      Transaction.create(invoice_id: Invoice.last.id, credit_card_number: 4654405418249632, result: "success")
    end
    10.times do
      create(:item, unit_price: 10, merchant_id: @merchant5.id)
      Invoice.create(customer_id: customer.id, status: "shipped", merchant_id: @merchant5.id)
      InvoiceItem.create(unit_price: Item.last.unit_price, item_id: Item.last.id, quantity: 6, invoice_id: Invoice.last.id)
      Transaction.create(invoice_id: Invoice.last.id, credit_card_number: 4654405418249632, result: "success")
    end
  end

  it 'can find return a variable number of merchants ranked by total revenue' do
    number_to_return = 5
    
    get "/api/v1/merchants/most_revenue?quantity=#{number_to_return}"

    expect(response).to be_successful

    merchant_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_response[:data].length).to eq(5)
    expect(merchant_response[:data].first[:id]).to eq(@merchant1.id.to_s)
    expect(merchant_response[:data].last[:id]).to eq(@merchant5.id.to_s)
  end

  it 'can find return a variable number of merchants ranked by total items sold' do
    number_to_return = 5
    
    get "/api/v1/merchants/most_items?quantity=#{number_to_return}"

    expect(response).to be_successful

    merchant_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_response[:data].length).to eq(5)
    expect(merchant_response[:data].first[:id]).to eq(@merchant1.id.to_s)
    expect(merchant_response[:data].last[:id]).to eq(@merchant5.id.to_s)
  end
end