FactoryBot.define do
  factory :item do
    merchant

    name { Faker::Commerce.product_name }
    description { Faker::ChuckNorris.fact }
    unit_price { Faker::Number.within(range: 1..100000) }
  end
end
