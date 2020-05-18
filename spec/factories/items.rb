FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    unit_price { 12.50 }
    association :merchant_id, factory: :merchant
  end
end