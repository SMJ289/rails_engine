FactoryBot.define do
  factory :merchant do
    name { Faker::FunnyName.two_word_name }
  end
end