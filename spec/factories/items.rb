FactoryBot.define do
  factory :item do
    name { Faker::Beer.name }
    description { Faker::Beer.style }
    unit_price { Faker::Number.number(digits: 3) }
  end
end
