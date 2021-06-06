FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Quote.yoda }
    unit_price { Faker::Number.number(digits: 7) }
    merchant { nil }
  end
end
