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
    it '.find_by_params()' do
      item1 = create(:item, name: 'Steve Item', description: 'a', unit_price: 10.75)
      item2 = create(:item, name: 'Bob Item', description: 'b', unit_price: 12.75 )
      item3 = create(:item, name: 'Sue Item', description: 'c', unit_price: 11.75)
      
      query_params1 = {'name' => "eve"}
      query_params2 = {'name' => "st"}
      query_params3 = {'name' => "ob"}

      expect(Item.find_by_params(query_params1)).to eq(item1)
      expect(Item.find_by_params(query_params2)).to eq(item1)
      expect(Item.find_by_params(query_params3)).to eq(item2)

      query_params4 = {'name' => "eve", 'description' => 'a'}
      query_params5 = {'name' => "st", 'description' => 'a'}
      query_params6 = {'name' => "ob", 'description' => 'b'}

      expect(Item.find_by_params(query_params4)).to eq(item1)
      expect(Item.find_by_params(query_params5)).to eq(item1)
      expect(Item.find_by_params(query_params6)).to eq(item2)

      query_params7 = {'name' => "eve", 'description' => 'a', 'unit_price' => 10.75}
      query_params8 = {'name' => "st", 'description' => 'a', 'unit_price' => 10.75}
      query_params9 = {'name' => "ob", 'description' => 'b', 'unit_price' => 12.75}

      expect(Item.find_by_params(query_params7)).to eq(item1)
      expect(Item.find_by_params(query_params8)).to eq(item1)
      expect(Item.find_by_params(query_params9)).to eq(item2)
    end

    it '.find_all_by_params()' do
      item1 = create(:item, name: 'Steve Item', description: 'aa', unit_price: 10.75)
      item2 = create(:item, name: 'Bob Item', description: 'ab', unit_price: 10.75 )
      item3 = create(:item, name: 'Sue Item', description: 'ac', unit_price: 10.75)
      item4 = create(:item, name: 'Sue Object', description: 'cc', unit_price: 11.50)
      
      query_params1 = {'name' => "it"}
      query_params2 = {'name' => "te"}
      query_params3 = {'name' => "em"}

      expect(Item.find_all_by_params(query_params1).length).to eq(3)
      expect(Item.find_all_by_params(query_params2).length).to eq(3)
      expect(Item.find_all_by_params(query_params3).length).to eq(3)

      query_params4 = {'name' => "it", 'description' => 'a'}
      query_params5 = {'name' => "te", 'description' => 'a'}
      query_params6 = {'name' => "em", 'description' => 'a'}

      expect(Item.find_all_by_params(query_params4).length).to eq(3)
      expect(Item.find_all_by_params(query_params5).length).to eq(3)
      expect(Item.find_all_by_params(query_params6).length).to eq(3)

      query_params7 = {'name' => "it", 'description' => 'a', 'unit_price' => 10.75}
      query_params8 = {'name' => "te", 'description' => 'a', 'unit_price' => 10.75}
      query_params9 = {'name' => "em", 'description' => 'a', 'unit_price' => 10.75}

      expect(Item.find_all_by_params(query_params7).length).to eq(3)
      expect(Item.find_all_by_params(query_params8).length).to eq(3)
      expect(Item.find_all_by_params(query_params9).length).to eq(3)
    end
  end
end