FactoryBot.define do
  factory :item do
    name { Faker::Name.first_name}
    description { Faker::ChuckNorris.fact }
    unit_price {Faker::Number.number(digits: 2)}
    association :merchant
  end
end
