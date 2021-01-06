FactoryBot.define do
  factory :item do
    name { Faker::Beer.name }
    description { Faker::Beer.style }
    unit_price { Faker::Number.between(from: 1, to: 10) }
  end
end
