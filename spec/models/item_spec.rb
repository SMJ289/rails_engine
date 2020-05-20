require 'rails_helper'

RSpec.describe Item do 
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
  end
  
  describe 'relationships'do
  it {should have_many(:invoices).through(:invoice_items)}
  it {should belong_to :merchant}
  end

  describe 'class methods' do
    it '.find_by_name()' do
      item1 = create(:item, name: 'Steve Item')
      item2 = create(:item, name: 'Bob Item')
      item3 = create(:item, name: 'Sue Item')

      expect(Item.find_by_name('eve')).to eq(item1)
      expect(Item.find_by_name('St')).to eq(item1)
      expect(Item.find_by_name('ob')).to eq(item2)
    end

    it '.find_all_by_name()' do
      item1 = create(:item, name: 'Steve Item')
      item2 = create(:item, name: 'Bob Item')
      item3 = create(:item, name: 'Sue Item')
      item4 = create(:item, name: 'WooHoo')

      expect(Item.find_all_by_name('it').length).to eq(3)
      expect(Item.find_all_by_name('EM').length).to eq(3)
      expect(Item.find_all_by_name('te').length).to eq(3)
    end

    it '.find_by_description()' do
      item1 = create(:item, description: 'An apple')
      item2 = create(:item, description: 'The banana')
      item3 = create(:item, description: 'a smelly orange')

      expect(Item.find_by_description('app')).to eq(item1)
      expect(Item.find_by_description('the')).to eq(item2)
      expect(Item.find_by_description('range')).to eq(item3)
    end

    it '.find_all_by_description()' do
      item1 = create(:item, description: 'The apple')
      item2 = create(:item, description: 'The banana')
      item3 = create(:item, description: 'The smelly orange')
      item4 = create(:item, description: 'Grape')

      expect(Item.find_all_by_description('the').length).to eq(3)
      expect(Item.find_all_by_description('a').length).to eq(4)
      expect(Item.find_all_by_description('he').length).to eq(3)
    end

    it '.find_by_price()' do
      item1 = create(:item, unit_price: 10.50)
      item2 = create(:item, unit_price: 11.97)
      item3 = create(:item, unit_price: 12.52)

      expect(Item.find_by_price(10.50)).to eq(item1)
      expect(Item.find_by_price(11.97)).to eq(item2)
      expect(Item.find_by_price(12.52)).to eq(item3)
    end

    it '.find_all_by_price()' do
      item1 = create(:item, unit_price: 10.50)
      item2 = create(:item, unit_price: 10.50)
      item3 = create(:item, unit_price: 10.50)
      item4 = create(:item, unit_price: 9.00)

      expect(Item.find_all_by_price(10.50).length).to eq(3)
    end
  end
end