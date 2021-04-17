FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence(word_count: 5) }
    unit_price { Faker::Number.number(digits: 5) }
    merchant
  end
end
