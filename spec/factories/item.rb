FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Coffee.notes }
    unit_price { Faker::Number.number(digits: 4) }
    merchant
  end
end
