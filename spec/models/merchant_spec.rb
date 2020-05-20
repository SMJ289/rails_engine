require 'rails_helper'

RSpec.describe Merchant do 
  describe 'validations' do
    it {should validate_presence_of :name}
  end
  
  describe 'relationships'do
    it {should have_many :items}
    it {should have_many :invoices}
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
  end

  describe 'class methods' do
    it '.find_all_by_name()' do
      merchant1 = Merchant.create(name: 'Steve World')
      merchant2 = Merchant.create(name: 'Bob World')
      merchant3 = Merchant.create(name: 'Sue World')

      expect(Merchant.find_all_by_name('WO').length).to eq(3)
      expect(Merchant.find_all_by_name('or').length).to eq(3)
      expect(Merchant.find_all_by_name('ld').length).to eq(3)
    end
  end
end