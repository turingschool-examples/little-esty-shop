FactoryBot.define do
  factory :item do
    name { Faker::Lorem.word}
    description { Faker::Lorem.sentence }
    unit_price {Faker::Number.number(digits: 2)}
    association :merchant
  end
end
