require 'rails_helper'

RSpec.describe Merchant do 
  describe 'validations' do
    it {should validate_presence_of :name}
  end
  
  describe 'relationships'do
    it {should have_many :items}
    it {should have_many :invoices}
    it {should have_many(:invoice_items).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe 'class methods' do
    it '.find_by_name()' do
      merchant1 = Merchant.create(name: 'Steve World')
      merchant2 = Merchant.create(name: 'Bob World')
      merchant3 = Merchant.create(name: 'Sue World')

      expect(Merchant.find_by_name('eve')).to eq(merchant1)
      expect(Merchant.find_by_name('St')).to eq(merchant1)
      expect(Merchant.find_by_name('ob')).to eq(merchant2)
    end

    it '.find_all_by_name()' do
      merchant1 = Merchant.create(name: 'Steve World')
      merchant2 = Merchant.create(name: 'Bob World')
      merchant3 = Merchant.create(name: 'Sue World')

      expect(Merchant.find_all_by_name('WO').length).to eq(3)
      expect(Merchant.find_all_by_name('or').length).to eq(3)
      expect(Merchant.find_all_by_name('ld').length).to eq(3)
    end

    it '.find_most_revenue()' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      customer = Customer.create(first_name: "steve", last_name: "meyers")

      10.times do
        create(:item, unit_price: 10, merchant_id: merchant1.id)
        Invoice.create(customer_id: customer.id, status: "shipped", merchant_id: merchant1.id)
        InvoiceItem.create(unit_price: Item.last.unit_price, item_id: Item.last.id, quantity: 10, invoice_id: Invoice.last.id)
        Transaction.create(invoice_id: Invoice.last.id, credit_card_number: 4654405418249632, result: "success")
      end
      10.times do
        create(:item, unit_price: 10, merchant_id: merchant2.id)
        Invoice.create(customer_id: customer.id, status: "shipped", merchant_id: merchant2.id)
        InvoiceItem.create(unit_price: Item.last.unit_price, item_id: Item.last.id, quantity: 9, invoice_id: Invoice.last.id)
        Transaction.create(invoice_id: Invoice.last.id, credit_card_number: 4654405418249632, result: "success")
      end
      10.times do
        create(:item, unit_price: 10, merchant_id: merchant3.id)
        Invoice.create(customer_id: customer.id, status: "shipped", merchant_id: merchant3.id)
        InvoiceItem.create(unit_price: Item.last.unit_price, item_id: Item.last.id, quantity: 8, invoice_id: Invoice.last.id)
        Transaction.create(invoice_id: Invoice.last.id, credit_card_number: 4654405418249632, result: "success")
      end

      expect(Merchant.find_most_revenue(2).length).to eq(2)
      expect(Merchant.find_most_revenue(2).first).to eq(merchant1)
      expect(Merchant.find_most_revenue(2).last).to eq(merchant2)
    end

    it '.find_most_items_sold()' do
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      customer = Customer.create(first_name: "steve", last_name: "meyers")

      10.times do
        create(:item, unit_price: 10, merchant_id: merchant1.id)
        Invoice.create(customer_id: customer.id, status: "shipped", merchant_id: merchant1.id)
        InvoiceItem.create(unit_price: Item.last.unit_price, item_id: Item.last.id, quantity: 10, invoice_id: Invoice.last.id)
        Transaction.create(invoice_id: Invoice.last.id, credit_card_number: 4654405418249632, result: "success")
      end
      10.times do
        create(:item, unit_price: 10, merchant_id: merchant2.id)
        Invoice.create(customer_id: customer.id, status: "shipped", merchant_id: merchant2.id)
        InvoiceItem.create(unit_price: Item.last.unit_price, item_id: Item.last.id, quantity: 9, invoice_id: Invoice.last.id)
        Transaction.create(invoice_id: Invoice.last.id, credit_card_number: 4654405418249632, result: "success")
      end
      10.times do
        create(:item, unit_price: 10, merchant_id: merchant3.id)
        Invoice.create(customer_id: customer.id, status: "shipped", merchant_id: merchant3.id)
        InvoiceItem.create(unit_price: Item.last.unit_price, item_id: Item.last.id, quantity: 8, invoice_id: Invoice.last.id)
        Transaction.create(invoice_id: Invoice.last.id, credit_card_number: 4654405418249632, result: "success")
      end

      expect(Merchant.find_most_revenue(2).length).to eq(2)
      expect(Merchant.find_most_revenue(2).first).to eq(merchant1)
      expect(Merchant.find_most_revenue(2).last).to eq(merchant2)
    end
  end
end